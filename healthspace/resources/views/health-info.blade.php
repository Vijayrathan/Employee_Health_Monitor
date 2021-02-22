<x-app-layout>
	<div class="py-12">
		<div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
			<div class="flex flex-col">
				<div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
					<div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
						<div class="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
							<table class="min-w-full divide-y divide-gray-200">
								<thead class="bg-gray-50">
									<tr>
										<th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
											EMPLOYEE ID
										</th>
										<th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
											CHOLESTEROL
										</th>
										<th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
											GLUCOSE
										</th>
										<th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
											TEMPERATURE
										</th>
										<th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
											B.P
										</th>
										<th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
											HEART RATE
										</th>
										<th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
											SPO2
										</th>
									</tr>
								</thead>
								<tbody>
									@foreach($employeeHealthData as $data)
									<!-- Odd row -->
									<tr class="bg-white">
										<td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
											{{ $data->emp_id }}
										</td>
										<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            @if($data->cholestrol > 240)
                                            <span class="text-red-500 font-bold">
                                            @else
                                            <span>
                                            @endif
											{{ $data->cholestrol }}
                                            </span>
										</td>
										<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            @if($data->glucose > 200)
                                            <span class="text-red-500 font-bold">
                                            @else
                                            <span>
                                            @endif
											{{ $data->glucose}}
                                            </span>
										</td>
										<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            @if($data->temperature > 99.0)
                                            <span class="text-red-500 font-bold">
                                            @else
                                            <span>
                                            @endif
											{{ $data->temperature }}
                                            </span>
                                        </td>
										<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
											@if($data->pressure > 140)
                                            <span class="text-red-500 font-bold">
                                            @else
                                            <span>
                                            @endif
											{{ $data->pressure }}
                                            </span>
										</td>
										<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
											@if($data->heart > 115)
                                            <span class="text-red-500 font-bold">
                                            @else
                                            <span>
                                            @endif
											{{ $data->heart }}
                                            </span>
										</td>
										<td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
											@if($data->oxygen > 96)
                                            <span class="text-red-500 font-bold">
                                            @else
                                            <span>
                                            @endif
											{{ $data->oxygen }}
                                            </span>
										</td>
									</tr>
									@endforeach

									<!-- More items... -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</x-app-layout>
