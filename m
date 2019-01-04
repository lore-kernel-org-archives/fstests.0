Received: from szxga05-in.huawei.com ([45.249.212.191]:16679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727039AbfADI4I (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Jan 2019 03:56:08 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2125847BFDD82
        for <fstests@vger.kernel.org>; Fri,  4 Jan 2019 16:56:05 +0800 (CST)
Subject: Re: [PATCH 3/5] generic/131: wait until the server is ready
References: <20181229023452.28074-1-houtao1@huawei.com>
 <20181229023452.28074-4-houtao1@huawei.com> <20181229081430.GG21777@desktop>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <d258d755-a081-72c8-e596-6ec16fa193cb@huawei.com>
Date: Fri, 4 Jan 2019 16:56:04 +0800
MIME-Version: 1.0
In-Reply-To: <20181229081430.GG21777@desktop>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

On 2018/12/29 16:14, Eryu Guan wrote:
> On Sat, Dec 29, 2018 at 10:34:50AM +0800, Hou Tao wrote:
>> When running xfstests under KVM VM and the load of host is high,
>> only delaying 1s and checking the readiness of server are not
>> enough, and the test case will fail early.
>>
>> Fix it by repeatedly checking the readiness signal until it's found,
>> or the server exits.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  tests/generic/131 | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/generic/131 b/tests/generic/131
>> index d7c146ae..1af86e77 100755
>> --- a/tests/generic/131
>> +++ b/tests/generic/131
>> @@ -37,13 +37,20 @@ TESTFILE=$TEST_DIR/lock_file
>>  src/locktest $TESTFILE 2>&1 > $TEST_DIR/server.out &
>>  locktest_pid1=$!
>>  
>> -sleep 1
>> +while true; do
>> +	sleep 1
> 
> Looks like we'll loop forever if the locktest process is there but fails
> to print out the server port due to random reasons.
> 
> I think it's better to retry N times and give up if the server is still
> not ready.
> 
Thanks for your suggestion, will send v2 soon.

> Thanks,
> Eryu
> 
>>  
>> -PORT=$(cat $TEST_DIR/server.out | grep "^server port: " | awk '{print $3}')
>> -if [ -z $PORT ]; then
>> -	echo "Could not get server port"
>> -	exit 1
>> -fi
>> +	PORT=$(cat $TEST_DIR/server.out | grep "^server port: " | awk '{print $3}')
>> +	if [ -n "$PORT" ]; then
>> +		break
>> +	fi
>> +
>> +	# check the existence of server process
>> +	if ! kill -s 0 $locktest_pid1 >/dev/null 2>&1; then
>> +		echo "Could not get server port"
>> +		exit 1
>> +	fi
>> +done
>>  
>>  # Start the client
>>  src/locktest -p $PORT -h localhost $TESTFILE 2>&1 > $TEST_DIR/client.out
>> -- 
>> 2.16.2.dirty
>>
> 
> 
