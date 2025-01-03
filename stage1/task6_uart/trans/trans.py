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
    else:
        return None

def main():
    # 配置串口
    ser = serial.Serial(
        port='/dev/tty.usbserial-110',  # 根据实际情况修改串口端口
        baudrate=9600,  # 设置波特率
        stopbits=serial.STOPBITS_ONE,  # 设置停止位
        parity=serial.PARITY_NONE  # 无校验位
    )

    if ser.is_open:
        print("Serial port opened successfully.")
    else:
        print("Failed to open serial port.")
        return

    try:
        # 发送数据
        data1 = int(input("请输入被除数的前两位（例如 74，十六进制）： "), 16)
        data2 = int(input("请输入被除数后两位："), 16)
        data3 = int(input("请输入除数前两位："), 16)
        data4 = int(input("请输入除数后两位："), 16)
        send_data(ser, data1)
        time.sleep(0.1)  # 等待0.1秒
        send_data(ser, data2)
        time.sleep(0.1)  # 等待0.1秒
        send_data(ser, data3)
        time.sleep(0.1)  # 等待0.1秒
        send_data(ser, data4)

        # 等待2秒
        time.sleep(2)

        # 接收数据
        receive_data(ser)
        receive_data(ser)
        receive_data(ser)
        receive_data(ser)

    except KeyboardInterrupt:
        print("Program interrupted by user.")

    finally:
        ser.close()
        print("Serial port closed.")

if __name__ == "__main__":
    main()
