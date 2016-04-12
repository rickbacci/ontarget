module ApplicationHelper
  def statuses
    ['Backlog', 'Ready', 'In-progress', 'Completed']
  end

  def times
    %w{ 5 300 600 1500 3000 }
  end

  def timer_values
    {
      '5'    => '5 seconds',
      '300'  => '5 minutes',
      '600'  => '10 minutes',
      '1500' => '25 minutes',
      '3000' => '50 minutes'
    }
  end

  def status_values
    {
      'Backlog'     => '1FFFFF',
      'Ready'       => 'F3FFFF',
      'In-progress' => 'FF5FFF',
      'Completed'   => 'FFF7FF'
    }
  end
end
