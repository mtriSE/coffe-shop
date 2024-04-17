import DrinkCard from "@components/DrinkCard";
import React from "react";

const Drinks = () => {
  return (
    <div className="flex justify-around flex-wrap gap-4">
      <DrinkCard />
      <DrinkCard />
      <DrinkCard />
      <DrinkCard />
      <DrinkCard />
      <DrinkCard />
      <DrinkCard />
    </div>
  );
};

export default Drinks;
