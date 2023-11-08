import logo from "./logo.svg";
import "./App.css";
import { useState } from "react";

function App() {
  const [todos, setTodos] = useState([]);
  const [todoValue, setTodoValue] = useState("")

  const addTodo = () => {
    setTodos((previous) => [...previous, todoValue])
    setTodoValue("")
  }

  return (
    <div className="App">
      <input value={todoValue} onChange={(e) => {
       setTodoValue(e.target.value)
      }}></input>
      <button className={""} onClick={addTodo}>Add Todo</button>
      {todos.map((value, index) => {
        return <h1>{index + 1}. {value}</h1>
      })}
    </div>
  );
}

export default App;
