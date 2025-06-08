import serial
import mysql.connector
from datetime import datetime

# Konfigurácia
SERIAL_PORT = 'COM6'  # Zmeňte podľa vášho portu
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'bezpecnost'
}

# Pripojenie k databáze
db = mysql.connector.connect(**DB_CONFIG)
cursor = db.cursor()

# Pripojenie k Arduinu
ser = serial.Serial(SERIAL_PORT, 9600, timeout=1)

try:
    while True:
        line = ser.readline().decode('utf-8').strip()
        if not line:
            continue
        
        print("Received:", line)
        
        # Spracovanie alarmu
        if "ALARM!" in line:
            cursor.execute("""
                INSERT INTO alarm_status (typ, message, room)
                VALUES ('senzor', 'ALARM aktivovaný!', 'system')
            """)
            db.commit()
        
        # Spracovanie senzorov
        elif "Door1:" in line and "Door2:" in line and "PIR:" in line:
            parts = line.split('|')
            door1 = int(parts[0].split(':')[1])
            door2 = int(parts[1].split(':')[1])
            pir = int(parts[2].split(':')[1])
            
            # Uloženie do databázy
            if door1 == 1:
                cursor.execute("""
                    INSERT INTO logs (typ, message, room)
                    VALUES ('dvere', 'Dvere boli otvorené', 'poschodie')
                """)
            
            if door2 == 1:
                cursor.execute("""
                    INSERT INTO logs (typ, message, room)
                    VALUES ('dvere', 'Okno bolo otvorené', 'poschodie')
                """)
            
            if pir == 1:
                cursor.execute("""
                    INSERT INTO logs (typ, message, room)
                    VALUES ('senzor', 'Pohyb detekovaný', 'prízemie')
                """)
            
            db.commit()
        
        # Aktualizácia stavu systému
        cursor.execute("""
            INSERT INTO system_status (alarm_on, status, uptime)
            VALUES (1, 'Aktívny', %s)
        """, (f"{datetime.now().timestamp()}s",))
        db.commit()

except KeyboardInterrupt:
    print("Program ukončený")
finally:
    ser.close()
    cursor.close()
    db.close()
