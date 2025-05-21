# Example for module
print("Imported!")
def fibonacci_write(n):
    a, b = 0, 1
    while b < n:
        print(b, end=' ')
        a, b = b, a + b

def fibonacci_return(n):
    result = []
    a, b = 0, 1
    while b < n:
        result.append(b)
        a, b = b, a + b
    return result

if __name__ == "__main__":
    
    fibonacci_write(1000)