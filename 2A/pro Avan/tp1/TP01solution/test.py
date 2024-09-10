import pytest

@pytest.fixture
def set1():
  return {4, 5, 6, 7, 6 , 5, 4}

@pytest.fixture
def set2():
  return set(range(1, 6))

def test_taille(set1):
  assert len(set1) == 4

def test_intersection(set1, set2):
 assert set1 & set2 == {4, 5}