import serial
import sys
import time
import os

# ZMEŇ NA SPRÁVNY COM PORT PRE ARDUINO
SERIAL_PORT = 'COM6'  

def send_command(command):
    try:
        print(f"Pokus o otvorenie portu {SERIAL_PORT}")
        ser = serial.Serial(SERIAL_PORT, 9600, timeout=2)
        time.sleep(2)  # Počkať na inicializáciu
        
        print(f"Posielam príkaz: {command}")
        ser.write(f"{command}\n".encode('utf-8'))
        
        # Počkať na odpoveď
        response = ser.readline().decode('utf-8').strip()
        print(f"Odpoveď od Arduina: {response}")
        
        ser.close()
        return True
    except Exception as e:
        print(f"Chyba: {str(e)}")
        # Skúsiť znova po chvíli
        time.sleep(1)
        try:
            ser = serial.Serial(SERIAL_PORT, 9600, timeout=2)
            ser.write(f"{command}\n".encode('utf-8'))
            ser.close()
            return True
        except Exception as e2:
            print(f"Druhý pokus zlyhal: {str(e2)}")
            return False

if __name__ == "__main__":
    if len(sys.argv) > 1:
        command = sys.argv[1]
        print(f"Spúšťam alarm_control.py s príkazom: {command}")
        
        # Získajte cestu k súboru pre debug
        print(f"Pracovný priečinok: {os.getcwd()}")
        
        if send_command(command):
            print(f"Príkaz {command} úspešne odoslaný")
            sys.exit(0)
        else:
            print("Nepodarilo sa odoslať príkaz")
            sys.exit(1)
    else:
        print("Chýbajúci príkaz. Použitie: python alarm_control.py [ALARM_ON|ALARM_OFF]")
        sys.exit(1)