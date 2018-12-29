Received: from mail-pf1-f195.google.com ([209.85.210.195]:45253 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeL2IOh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 29 Dec 2018 03:14:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so11365303pfd.12
        for <fstests@vger.kernel.org>; Sat, 29 Dec 2018 00:14:36 -0800 (PST)
Date: Sat, 29 Dec 2018 16:14:30 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 3/5] generic/131: wait until the server is ready
Message-ID: <20181229081430.GG21777@desktop>
References: <20181229023452.28074-1-houtao1@huawei.com>
 <20181229023452.28074-4-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229023452.28074-4-houtao1@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Hou Tao <houtao1@huawei.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Dec 29, 2018 at 10:34:50AM +0800, Hou Tao wrote:
> When running xfstests under KVM VM and the load of host is high,
> only delaying 1s and checking the readiness of server are not
> enough, and the test case will fail early.
> 
> Fix it by repeatedly checking the readiness signal until it's found,
> or the server exits.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  tests/generic/131 | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/generic/131 b/tests/generic/131
> index d7c146ae..1af86e77 100755
> --- a/tests/generic/131
> +++ b/tests/generic/131
> @@ -37,13 +37,20 @@ TESTFILE=$TEST_DIR/lock_file
>  src/locktest $TESTFILE 2>&1 > $TEST_DIR/server.out &
>  locktest_pid1=$!
>  
> -sleep 1
> +while true; do
> +	sleep 1

Looks like we'll loop forever if the locktest process is there but fails
to print out the server port due to random reasons.

I think it's better to retry N times and give up if the server is still
not ready.

Thanks,
Eryu

>  
> -PORT=$(cat $TEST_DIR/server.out | grep "^server port: " | awk '{print $3}')
> -if [ -z $PORT ]; then
> -	echo "Could not get server port"
> -	exit 1
> -fi
> +	PORT=$(cat $TEST_DIR/server.out | grep "^server port: " | awk '{print $3}')
> +	if [ -n "$PORT" ]; then
> +		break
> +	fi
> +
> +	# check the existence of server process
> +	if ! kill -s 0 $locktest_pid1 >/dev/null 2>&1; then
> +		echo "Could not get server port"
> +		exit 1
> +	fi
> +done
>  
>  # Start the client
>  src/locktest -p $PORT -h localhost $TESTFILE 2>&1 > $TEST_DIR/client.out
> -- 
> 2.16.2.dirty
> 
