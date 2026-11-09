
import React, { useEffect, useState } from 'react'
import tmdbAxiosInstance from '../tmdbAxiosInstance'
import './Row.css'

function Row({ title, fetchUrl }) {
  const [allMovies, setAllMovies] = useState([])
  const base_url = "https://image.tmdb.org/t/p/original/"

  useEffect(() => {
    const fetchData = async () => {
      try {
        const { data } = await tmdbAxiosInstance.get(fetchUrl)
        setAllMovies(data.results || [])
      } catch (error) {
        console.error("Error fetching movies:", error)
      }
    }

    fetchData()
  }, [fetchUrl])

  return (
    <div className='row'>
      <h1>{title}</h1>

      <div className="all_movies">
        {allMovies.map((item) => (
          <div className='ba' key={item.id}>
            <div className='iim'>
              <img
                className='movie'
                src={`${base_url}${item.poster_path}`}
                alt={item.original_title || item.name || "Movie poster"}
              />

              <div className='back'>
                <img
                  className='bacimg'
                  src={`${base_url}${item.backdrop_path}`}
                  alt={item.original_title || item.name || "Movie backdrop"}
                />

                <div style={{ padding: "10px" }}>
                  <div className='butt'>
                    <button className='watchnow'>Watch now</button>
                    <button className='plus'>+</button>
                  </div>

                  <h2>{item.original_title || item.name}</h2>

                  <div style={{ display: "flex" }}>
                    <h3>{item.release_date?.slice(0, 4) || item.first_air_date?.slice(0, 4)}</h3>
                    <h3>&nbsp;.&nbsp;</h3>
                    <h3>Rating: {item.vote_average}</h3>
                  </div>

                  <p>{item.overview?.slice(0, 80)}</p>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}

export default Row
