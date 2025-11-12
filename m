Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC033348479
	for <fstests@vger.kernel.org>; Wed, 12 Nov 2025 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971540; cv=none; b=SavOIgsWvYUEkURFFbyUpUqzlkhVrtCF4sKByoIQmqvZAh3fBERV9u5UPGNKinBQiXUVodsUP0aCOZ8/HHL9CyufOJD86ejvG2Gx6HsoOqm2thq+RIiYQGbI+CdMkSenmXjI4aiv2jONGvQh5ilmsB2KhQWM1EGFIaVExb8H9eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971540; c=relaxed/simple;
	bh=fXatEtLUdElKir1qmx3LiGvaBVeHp3KnXO/PovXYUvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMpT9/uupvp30o/aj8Qx+zV0AOJiNSEL+k5H/Q/slCD3WxFK9xaAKqY04NmGBvmGJZSO81P/gTNrBno4jUyhUx3qorCaRJRwznvGTrkiksIy/MQmOujTDFeZUHm2DPT5pLIWSW/UAtJ6iAo/b/tulUohNVjzclOC9hTWQ6QTpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8qf/6kh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8qf/6kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79985C4CEF8;
	Wed, 12 Nov 2025 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762971540;
	bh=fXatEtLUdElKir1qmx3LiGvaBVeHp3KnXO/PovXYUvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f8qf/6khqQrskJ2Un0d5G/9WWF6slZKVnsrtoOB5GhCJry+0DbsJ9kcl9F8DvFmIq
	 rXyUIPzAxME8A5SS5rfKaQes992yEZX3QlcHfzwYL4nBhFWZvS+/915mJq4BNezxqh
	 fAw/3/CpUeM065pJ/mF+3mRXJaDrwcVqoMWDmcUm4NFMyW5tNJtbcUtN6FmP8YwZEb
	 gzJl1kttiV6l7us6seaCNYoq7FyIVqoXVJEbk0pGeUEkgnvTTFudZoy0A5vkCp5VqW
	 cjTSIaiTTnU6RugQj3ZUUvABz2dH4HteEZKuoZ7VV/CW2R3xsJ/IMJaEAvc6+d+4b6
	 LS2+OW0OWjEPA==
Date: Wed, 12 Nov 2025 10:18:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ravi Singh <ravising@redhat.com>
Cc: fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH] README: improve README formatting and clarity
Message-ID: <20251112181859.GF196366@frogsfrogsfrogs>
References: <20251111115658.603209-1-ravising@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111115658.603209-1-ravising@redhat.com>

On Tue, Nov 11, 2025 at 06:56:58AM -0500, Ravi Singh wrote:
> - Standardize shell command prompts with '$' for readability

The commands are supposed to be run in a root shell, so '#' is more
appropriate, because '#' is the root shell prompt.

--D

> - Correct minor typos
> - Clarify instructions for running tests.
> 
> Signed-off-by: Ravi Singh <ravising@redhat.com>
> ---
>  README | 44 ++++++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
> 
> diff --git a/README b/README
> index 9e9afe3c..6edcdf31 100644
> --- a/README
> +++ b/README
> @@ -216,6 +216,8 @@ Setup Environment
>  5. Copy local.config.example to local.config and edit as needed. The TEST_DEV
>     and TEST_DIR are required.
>  
> +   $ cp local.config.example local.config
> +
>  6. (optional) Create fsgqa test users and groups:
>  
>     $ sudo useradd -m fsgqa
> @@ -241,13 +243,13 @@ Setup Environment
>  
>  For example, to run the tests with loopback partitions:
>  
> -    # xfs_io -f -c "falloc 0 10g" test.img
> -    # xfs_io -f -c "falloc 0 10g" scratch.img
> -    # mkfs.xfs test.img
> -    # losetup /dev/loop0 ./test.img
> -    # losetup /dev/loop1 ./scratch.img
> -    # mkdir -p /mnt/test && mount /dev/loop0 /mnt/test
> -    # mkdir -p /mnt/scratch
> +    $ xfs_io -f -c "falloc 0 10g" test.img
> +    $ xfs_io -f -c "falloc 0 10g" scratch.img
> +    $ mkfs.xfs test.img
> +    $ losetup /dev/loop0 ./test.img
> +    $ losetup /dev/loop1 ./scratch.img
> +    $ mkdir -p /mnt/test && mount /dev/loop0 /mnt/test
> +    $ mkdir -p /mnt/scratch
>  
>  The config for the setup above is:
>  
> @@ -316,7 +318,7 @@ Tools specification:
>        test, if the kernel supports kmemleak.
>   - fsstress:
>      - Set FSSTRESS_AVOID and/or FSX_AVOID, which contain options added to
> -      the end of fsstresss and fsx invocations, respectively, in case you wish
> +      the end of fsstress and fsx invocations, respectively, in case you wish
>        to exclude certain operational modes from these tests.
>   - core dumps:
>      - Set COREDUMP_COMPRESSOR to a compression program to compress crash dumps.
> @@ -378,25 +380,27 @@ ______________________
>  
>  Running tests:
>  
> -    - cd xfstests
> +    - $ cd xfstests-dev
>      - By default the tests suite will run all the tests in the auto group. These
>        are the tests that are expected to function correctly as regression tests,
>        and it excludes tests that exercise conditions known to cause machine
>        failures (i.e. the "dangerous" tests).
> -    - ./check '*/001' '*/002' '*/003'
> -    - ./check '*/06?'
> -    - Groups of tests maybe ran by: ./check -g [group(s)]
> +          $ ./check
> +    - Running specific tests:
> +          $ ./check '*/001' '*/002' '*/003'
> +          $ ./check '*/06?'
> +    - Groups of tests maybe ran by: $ ./check -g [group(s)]
>        See the tests/*/group.list files after building xfstests to learn about
>        each test's group memberships.
>      - If you want to run all tests regardless of what group they are in
> -      (including dangerous tests), use the "all" group: ./check -g all
> -    - To randomize test order: ./check -r [test(s)]
> +      (including dangerous tests), use the "all" group: $ ./check -g all
> +    - To randomize test order: $ ./check -r [test(s)]
>      - You can explicitly specify NFS/AFS/CIFS/OVERLAY, otherwise
>        the filesystem type will be autodetected from $TEST_DEV:
> -        - for running nfs tests: ./check -nfs [test(s)]
> -        - for running afs tests: ./check -afs [test(s)]
> -        - for running cifs/smb3 tests: ./check -cifs [test(s)]
> -        - for overlay tests: ./check -overlay [test(s)]
> +        - for running nfs tests: $ ./check -nfs [test(s)]
> +        - for running afs tests: $ ./check -afs [test(s)]
> +        - for running cifs/smb3 tests: $ ./check -cifs [test(s)]
> +        - for overlay tests: $ ./check -overlay [test(s)]
>            The TEST and SCRATCH partitions should be pre-formatted
>            with another base fs, where the overlay dirs will be created
>  
> @@ -438,7 +442,7 @@ Test script environment:
>  	    $TEST_DEV.
>  
>  	(b) mkfs a new XFS filesystem on $SCRATCH_DEV, and mount this
> -	    on $SCRATCH_MNT. Call the the _require_scratch function
> +	    on $SCRATCH_MNT. Call the _require_scratch function
>              on startup if you require use of the scratch partition.
>              _require_scratch does some checks on $SCRATCH_DEV &
>              $SCRATCH_MNT and makes sure they're unmounted. You should
> @@ -507,7 +511,7 @@ Test script environment:
>  	initialise the test environment correctly, the the build infrastructure
>  	also scans the test files for _begin_fstests invocations. It does this
>  	to compile the group lists that are used to determine which tests to run
> -	when `check` is executed. In other words, test files files must call
> +	when `check` is executed. In other words, test files must call
>  	_begin_fstest with their intended groups or they will not be run.
>  
>  	However, because the build infrastructure also uses _begin_fstests as
> -- 
> 2.51.1
> 
> 
