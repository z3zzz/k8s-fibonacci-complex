import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import * as Api from '../../utils/api';
import './fib.css';

interface IndexValuePair {
  index: string;
  value: number;
}

const Fib: React.FC = () => {
  const [searchedIndexes, setSearchedIndexes] = useState<number[]>([]);
  const [searchedKeyValues, setSearchedKeyValues] = useState<IndexValuePair[]>(
    []
  );
  const [index, setIndex] = useState('');
  const [flag, setFlag] = useState(0);

  const onClick = async (e: React.MouseEvent<HTMLButtonElement>) => {
    e.preventDefault();

    const { data } = await Api.post('/api/values', { index: parseInt(index) });
    console.log(data);

    setIndex('');
    setFlag(flag + 1);
  };

  useEffect(() => {
    async function fetchIndexes() {
      const { data }: { data: number[] } = await Api.get('/api/indexes');

      setSearchedIndexes(data);
    }

    async function fetchKeyValues() {
      const { data }: { data: IndexValuePair[] } = await Api.get('/api/values');

      setSearchedKeyValues(data);
    }

    fetchIndexes();
    fetchKeyValues();
  }, [flag]);

  return (
    <div className="fib-columns">
      <div className="fib-column-link">
        <Link to="/other">Go to other page</Link>
      </div>
      <div className="fib-column-main">
        <form>
          <label>Enter your index: </label>
          <input value={index} onChange={(e) => setIndex(e.target.value)} />
          <button onClick={onClick}>Submit</button>
        </form>

        <h3>Indexes you have seen: </h3>
        <p>{searchedIndexes.map((number) => number).join(', ')}</p>

        <h3>Caculated Values: </h3>
        {searchedKeyValues.map(({ index, value }) => (
          <div key={index}>
            For index {index} the fibonacci number is {value}
          </div>
        ))}
      </div>
    </div>
  );
};

export default Fib;
