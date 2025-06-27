create or replace function atualiza_lat_long()
   returns mensagem as $$
declare 
	 titles mensagem default '';
	 rec_lista  record;
	 cur_lista cursor(uf varchar, km numeric) 
		 for select uf, km, avg(latitude) as latitude, avg(longitude) as longitude
		     from MPCA_MD.acidentes;

begin
   -- open the cursor
   open cur_films(p_year);
	contador = 0;

   loop
    -- fetch row into the film
      fetch cur_lista into rec_lista;
         UPDATE MPCA_MD.acidentes 
         SET latitude = rec_lista.latitude, 
             longitude = rec_lista.longitude
         WHERE latitude is null 
         AND uf = rec_lista.uf 
         AND km = rec_lista.km;

      contador = contador + 1;

    -- exit when no more row to fetch
      exit when not found;

    -- build the output
      --if rec_film.title like '%ful%' then 
      --   titles := titles || ',' || rec_film.title || ':' || rec_film.release_year;
      --end if;
   end loop;
  
   -- close the cursor
   close cur_lista;

   mensagem = 'Foram percorridos ' || contador || ' registros!'

   return mensagem;
end; $$

language plpgsql;