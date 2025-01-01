import serial
import time

def send_data(ser, data):
    """发送8位数据到FPGA"""
    ser.write(data.to_bytes(1, byteorder='big'))
    print(f"Sent: {data}")

def receive_data(ser):
    """从FPGA接收8位数据"""
    if ser.in_waiting > 0:
        data = ser.read(1)
        received = int.from_bytes(data, byteorder='big')
        print(f"Received: {received}")
        return received
    return None

def main():
    # 配置串口
    ser = serial.Serial(
        port='/dev/tty.usbserial',  # 根据实际情况修改串口端口
        baudrate=9600,  # 设置波特率
        timeout=1
    )

    if ser.is_open:
        print("Serial port opened successfully.")
    else:
        print("Failed to open serial port.")
        return

    try:
        while True:
            # 发送数据
            send_data(ser, 0x55)  # 发送0x55作为示例数据
            time.sleep(1)  # 等待1秒

            # 接收数据
            receive_data(ser)
            time.sleep(1)  # 等待1秒

    except KeyboardInterrupt:
        print("Program interrupted by user.")

    finally:
        ser.close()
        print("Serial port closed.")

if __name__ == "__main__":
    main()