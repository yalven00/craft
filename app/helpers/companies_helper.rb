module CompaniesHelper
  def company_location(hash)
    location = []
    location << hash.postal_code if hash.postal_code
    location << hash.city if hash.city
    location << hash.street1 if hash.street1
    location << hash.street2 if hash.street2
    location.join(', ')
  end

  def company_link(company)
    if company.crunchbase.present?
      company
    elsif company.careers_page.present?
      company.careers_page
    else company.site
    end
  end

  def monthly_growth(company)
    if company.employees and company.employees_ma
      company.employees - company.employees_ma
    else ''
    end
  end

  def add_to_list_popover_content(user_lists, company_id)
    content = user_lists.map do |list| 
      content_tag(:a, list.name, {href: "/user_lists/#{list.id}/add/#{company_id}", data:{remote: true}})
    end
    content.join('<br />')
    return content
  end

  def chunk_categories(array)
    # [1, 2, 3, 4, 5, 6, 7] => [[1, 2, 3], [4, 5, 6], [7]] => {first: [1, 2, 3], second: [4, 5, 6], third: [7]}
    columns = 3
    len = array.length
    mid = len / columns
    chunks = []
    start = 0
    1.upto(columns) do |i|
      last = start + mid
      last = last - 1 unless len % columns >= i
      chunks << array[start..last] || []
      start = last + 1
    end
    return {first: chunks.first, second: chunks[1], third: chunks.last}
  end
end
