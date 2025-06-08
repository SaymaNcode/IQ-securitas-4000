import serial
import mysql.connector
import time
from datetime import datetime

# Konfigurácia
SERIAL_PORT = 'COM6'  # Zmeň podľa tvojho PC
BAUD_RATE = 9600

DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'bezpecnost'
}

# Pripojenie k databáze
db = mysql.connector.connect(**DB_CONFIG)
cursor = db.cursor()

# Pripojenie k sériovému portu
ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
time.sleep(2)  # počkaj na stabilizáciu portu

try:
    while True:
        # Poslanie príkazu pre bzučiak
        cursor.execute("SELECT value FROM settings WHERE key_name = 'buzzer_enabled'")
        buzzer_enabled = cursor.fetchone()[0]
        command = "BUZZER_ON" if buzzer_enabled == '1' else "BUZZER_OFF"
        ser.write((command + "\n").encode())

        # Čítanie dát zo sériového portu
        line = ser.readline().decode('utf-8', errors='ignore').strip()
        if not line:
            continue

        print("Prijaté:", line)

        # Spracovanie alarmu
        if "ALARM!" in line:
            cursor.execute("""
                INSERT INTO alarm_status (typ, message, room)
                VALUES ('senzor', 'ALARM aktivovaný!', 'system')
            """)
            db.commit()

        # Spracovanie dát zo senzorov
        elif "Door1:" in line and "Door2:" in line and "PIR:" in line:
            parts = line.split('|')
            door1 = int(parts[0].split(':')[1])
            door2 = int(parts[1].split(':')[1])
            pir = int(parts[2].split(':')[1])

            if door1 == 1:
                cursor.execute("""
                    INSERT INTO logs (typ, message, room)
                    VALUES ('dvere', 'Dvere boli otvorené', 'poschodie')
                """)

            if door2 == 1:
                cursor.execute("""
                    INSERT INTO logs (typ, message, room)
                    VALUES ('okna', 'Okno bolo otvorené', 'poschodie')
                """)

            if pir == 1:
                cursor.execute("""
                    INSERT INTO logs (typ, message, room)
                    VALUES ('senzor', 'Pohyb detekovaný', 'prízemie')
                """)

            db.commit()

        # Zápis systému a uptime
        uptime = int(time.time())  # unix timestamp
        cursor.execute("""
            INSERT INTO system_status (alarm_on, status, uptime)
            VALUES (1, 'Aktívny', %s)
        """, (uptime,))
        db.commit()

        time.sleep(1)

except KeyboardInterrupt:
    print("Program ukončený klávesnicou.")

finally:
    ser.close()
    cursor.close()
    db.close()
