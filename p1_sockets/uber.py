class Uber:
    def __init__(self, plate: int, available: bool):
        """
        Initializes the Uber instance with a license plate and availability status.
        
        Parameters:
        plate (int): The license plate number of the Uber.
        is_available (bool): Whether the Uber is available or not. Default is True.
        """
        self._plate = plate
        self._available = available

    def set_availability(self, available: bool):
        """Sets the availability status of the Uber."""
        self._available = available
    
    def is_available(self) -> bool:
        """Returns current status of the UBer """
        return self._available 
    
    def get_plate(self) -> int:
        """Return license plate of the uber"""
        return self._plate

