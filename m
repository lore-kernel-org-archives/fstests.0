Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4A3173A;
	Thu, 25 Jan 2024 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221799; cv=none; b=nZzlayIwAQo62MLLbVdtFKFLFXclCWZRM/2cfit1nJOTqCaX8DxVzcC5a3BvRboVfsTGa116YUyuTHYu+ZTxCQYvOIH9MSS9nv/8B8VkKWMQB+LtdIBc+bPEPshZbPI9H1+iqZ8ZAtBmFfTDlSdMAoGk2BiueiLYFuNj0VfgUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221799; c=relaxed/simple;
	bh=ZaB/vTdp4fRJuymijO+PblcWRkdOhbSunNCKtv9ZzQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsTlLh9XRqKmdTtzh4dnLj7XwtQvrIyn0qQqCqRAIxdkoY/v8psofbye6f5AfzovL+eTIO7FR2CrliiJuuBmn80+qHwvP5lBitkR6jesars9fyD61OfjdBvRezo3TX9dPbPmsxZrYlK1pn4/R4j10Ke/DcUD+1knSt0Ds+XrcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKcCy0A+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKcCy0A+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AF5C43390;
	Thu, 25 Jan 2024 22:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706221797;
	bh=ZaB/vTdp4fRJuymijO+PblcWRkdOhbSunNCKtv9ZzQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mKcCy0A+vVOwI/5TEqPRkNWiHQlrbBMrMaN6RxFzMD2EUZlK8oxXa5VweKYGmGPtx
	 5zdd/qFw+NEoJsABdt8/4+/EQEPBY97TfH+LmYNQqDYqh/Vt9UQMw20p3nYNvWjB1s
	 L7A74LlAbWdDK9dLbxHkfvRVqJDEk1OjTN35nVWNd2jjolTkobPDYewmiFpvCZ4XQx
	 KJwCMnGrsQPXKVRwJXKeRdRcaatP8WY0ZIZzECG65rxERtT3hIG4n4JM/Ex4KWozlC
	 EDrPBj8asd59A+avm/exaoboeWs/yuJ8+/w6Tue7MAuDPBjwhv3Sl5oIWvQjQR+A5f
	 rTRHdvtfoypoQ==
Date: Thu, 25 Jan 2024 14:29:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: kdevops@lists.linux.dev, Chandan Babu R <chandan.babu@oracle.com>,
	Amir Goldstein <amir73il@gmail.com>, p.raghav@samsung.com,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	zlang@redhat.com, Daniel Gomez <da.gomez@samsung.com>,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	fstests@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH kdevops] fstests: provide kconfig guidance for
 SOAK_DURATION
Message-ID: <20240125222956.GD6188@frogsfrogsfrogs>
References: <ZbLcXWI9bCdc9PZO@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbLcXWI9bCdc9PZO@bombadil.infradead.org>

On Thu, Jan 25, 2024 at 02:10:37PM -0800, Luis Chamberlain wrote:
> The kdevops test runner has supported a custom SOAK_DURATION for
> fstests, however we were not providing any guidance. This means folks
> likely disable this. Throw a bone and provide some basic guidance and
> use 2.5 hours as the default value. There are about 46 tests today
> which use soak duration, this means if you are testing serially it
> increase total test time by about 5 days than the previously known
> total test time.
> 
> Note that if you are using kernel-ci and using a max loop goal of 100
> that means 500 days extra, so about 1.3 years extra total test time.
> If enabling soak duration you may want to then re-evaluate your loop
> target goal for kernel-ci for kdevops.

Yikes, I wouldn't combine multiple runs with large SOAK_DURATION. ;)

You all might consider kicking all the soak tests over to a separate VM
or VMs so that the long soak test do not hold up the rest of the run.

> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> Chandan, Amir, lemme know what you think of a default 2.5 hours default
> if soak duration is enabled. The only thing is the math indicates that
> if you are going to enable kernel-ci we won't finish this year.
> 
> To be clear, we've picked up testing with soak duration seriously for
> our LBS testing. It is why we've been able to find pretty hard to
> reproduce issues even on the page cache for the baseline [0], ie, without
> LBS. While folks have seemed to have found value in adopting 2.5 hours
> and of the results we have found, it obviously means a scaling issue
> to consider to decide when we're done with testing our baseline.
> 
> At first I wrote this patch just to provide basic guidance for kdevops,
> but after doing a bit of the math on how it also extends total test
> time, *with* our kernel-ci effort, it reveals clearly we should probably
> reconsider lowering the kernel-ci threshold a bit if adopting soak
> duration.
> 
> CC'ing a bit wider audience so to get a bit better idea of what folks
> might consider a sensible value for your own testing too. From what
> we've been observing, SOAK_DURATION allows us to catch bugs faster than
> just increasing the kernel-ci count, however, using both let's us catch
> even more bugs too.
> 
> To help *reduce* the amount of time to test we've deployed many kdevops
> XFS clusters to help test the baseline. This is why our count time on
> kernel-ci no is about 50-60 with a soak duration of about 2.5 hours.
> 
> Also please not that the reported bugs so far are the ones with crashes,
> there are other failures too, but we just haven't had the time to disect
> and report failures which are non-fatal (crashes) as crashes have been
> our priority.
> 
> [0] https://github.com/linux-kdevops/kdevops/blob/master/docs/xfs-bugs.md
> 
>  playbooks/roles/fstests/defaults/main.yml |  3 +
>  workflows/fstests/Kconfig                 | 89 ++++++++++++++++++++---
>  workflows/fstests/Makefile.sparsefiles    |  4 +
>  3 files changed, 87 insertions(+), 9 deletions(-)
> 
> diff --git a/playbooks/roles/fstests/defaults/main.yml b/playbooks/roles/fstests/defaults/main.yml
> index 2f70f9549cde..4a1f5dec5827 100644
> --- a/playbooks/roles/fstests/defaults/main.yml
> +++ b/playbooks/roles/fstests/defaults/main.yml
> @@ -30,6 +30,9 @@ fstests_test_logdev_mkfs_opts: "/dev/null"
>  fstests_test_dev_zns: "/dev/null"
>  fstests_zns_enabled: False
>  
> +fstests_soak_duration_enable: False
> +fstests_soak_duration: 0
> +
>  fstests_uses_no_devices: False
>  fstests_generate_simple_config_enable: False
>  fstests_generate_nvme_live_config_enable: False
> diff --git a/workflows/fstests/Kconfig b/workflows/fstests/Kconfig
> index 985a7847b6c7..bbd8927b3cd3 100644
> --- a/workflows/fstests/Kconfig
> +++ b/workflows/fstests/Kconfig
> @@ -760,15 +760,23 @@ config FSTESTS_RUN_LARGE_DISK_TESTS
>  	  to run. The "large disk" requirement is test dependent, but
>  	  typically, it means a disk with capacity of at several 10G.
>  
> -config FSTESTS_SOAK_DURATION
> -	int "Custom Soak duration to be used"
> -	default 0
> +config FSTESTS_ENABLE_SOAK_DURATION
> +	bool "Enable custom soak duration time"
>  	help
> -	  Custom Soak duration to be used during test execution. If you set this
> -	  to a non-zero value then fstests will increase the amount of time it
> -	  takes to run certain tests which are time based and support using
> -	  SOAK_DURATION. A moderate high value setting for this is 9900 which is
> -	  2.5 hours.
> +	  Enable soak duration to be used during test execution. If you are not
> +	  interested in extending your testing then leave this disabled.
> +
> +	  Using a custom soak duration to a non-zero value then fstests will
> +	  increase the amount of time it takes to run certain tests which are
> +	  time based and support using SOAK_DURATION. A moderate high value
> +	  setting for this is 9900 which is 2.5 hours.

"A moderately high setting for this is "2.5h" for 2.5 hours."

FWIW, the ./check parser translates floating point numbers with suffixes
to integer seconds; see soak_duration.awk.

The part I don't know is if kdevops merely passes through the value as a
string; or actually treats this as an integer.  If the latter, then
please ignore my comment.

> +
> +	  Note that we have 46 tests today which will be able to use soak
> +	  duration if set. This means your test time will increase by the
> +	  soak duration * these number of tests. When soak duration is
> +	  enabled the test specific watchdog fstests_watchdog.py will be
> +	  aware of tests which require soak duration and consider before
> +	  reporting a possible hang.
>  
>  	  As of 2023-10-31 that consists of the following tests which use either
>  	  fsstress or fsx or fio. Tests either use SOAK_DURATION directly or they
> @@ -786,7 +794,7 @@ config FSTESTS_SOAK_DURATION
>  	  - generic/648 - fsstress + disk failures on loopback
>  	  - generic/650 - fsstress - multithreaded write + CPU hotplug
>  
> -	  The tests below use _scratch_xfs_stress_scrub() to stress
> +	  All the tests below use _scratch_xfs_stress_scrub() to stress
>  	  test an with fsstress with scrub or an alternate xfs_db operation.
>  
>  	  - xfs/285
> @@ -825,4 +833,67 @@ config FSTESTS_SOAK_DURATION
>  	  - xfs/729
>  	  - xfs/800
>  
> +if FSTESTS_ENABLE_SOAK_DURATION
> +
> +choice
> +	prompt "Soak duration value to use"
> +	default FSTESTS_SOAK_DURATION_HIGH
> +
> +config FSTESTS_SOAK_DURATION_CUSTOM
> +	bool "Custom"
> +	help
> +	  You want to specify the value yourself.
> +
> +config FSTESTS_SOAK_DURATION_PATHALOGICAL

"PATHOLOGICAL", and yes that high a setting is pathological. ;)

(Unless you're allocating one soak-fstest per VM in which case "1w"
might be appropriate.)

> +	bool "High (48 hours)"
> +	help
> +	  Use 48 hours for soak duration.
> +
> +	  Using this with 46 tests known to use soak duration means your test
> +	  time will increase by about 92 days, or a bit over 3 months if run
> +	  serially.
> +
> +config FSTESTS_SOAK_DURATION_HIGH
> +	bool "High (2.5 hours)"
> +	help
> +	  Use 2.5 hours for soak duration.
> +
> +	  Using this with 46 tests known to use soak duration means your test
> +	  time will increase by about 5 days if run serially.
> +
> +config FSTESTS_SOAK_DURATION_MID
> +	bool "Mid (1 hour)"
> +	help
> +	  Use 1 hour for soak duration.
> +
> +	  Using this with 46 tests known to use soak duration means your test
> +	  time will increase by about 2 days if run serially.

I wonder, is there any way to scan the number of soak test to generate
these figures automatically at configure time?  I'd guess no, since
kdevops kconfig comes before pulling and compiling, right?

--D

> +
> +config FSTESTS_SOAK_DURATION_LOW
> +	bool "Low (30 minutes)
> +	help
> +	  Use 30 minutes for soak duration.
> +
> +	  Using this with 46 tests known to use soak duration means your test
> +	  time will increase by about 1 day if run serially.
> +
> +endchoice
> +
> +config FSTESTS_SOAK_DURATION_CUSTOM_VAL
> +	int "Custom soak duration value (seconds)"
> +	default 0
> +	depends on FSTESTS_SOAK_DURATION_CUSTOM
> +	help
> +	  Enter your custom soak duration value in seconds.
> +
> +endif # FSTESTS_ENABLE_SOAK_DURATION
> +
> +config FSTESTS_SOAK_DURATION
> +	default 0 if !FSTESTS_ENABLE_SOAK_DURATION
> +	default FSTESTS_SOAK_DURATION_CUSTOM_VAL if FSTESTS_SOAK_DURATION_CUSTOM
> +	default 1800 if FSTESTS_SOAK_DURATION_LOW
> +	default 3600 if FSTESTS_SOAK_DURATION_MID
> +	default 9900 if FSTESTS_SOAK_DURATION_HIGH
> +	default 172800 if FSTESTS_SOAK_DURATION_PATHALOGICAL
> +
>  endif # KDEVOPS_WORKFLOW_ENABLE_FSTESTS
> diff --git a/workflows/fstests/Makefile.sparsefiles b/workflows/fstests/Makefile.sparsefiles
> index c5ca20a9c462..7dd129c4f9cc 100644
> --- a/workflows/fstests/Makefile.sparsefiles
> +++ b/workflows/fstests/Makefile.sparsefiles
> @@ -44,6 +44,10 @@ FSTESTS_ARGS += run_large_disk_tests='$(FSTESTS_RUN_LARGE_DISK_TESTS)'
>  FSTESTS_ARGS += run_auto_group_tests='$(FSTESTS_RUN_AUTO_GROUP_TESTS)'
>  FSTESTS_ARGS += run_custom_group_tests='$(FSTESTS_RUN_CUSTOM_GROUP_TESTS)'
>  FSTESTS_ARGS += exclude_test_groups='$(CONFIG_FSTESTS_EXCLUDE_TEST_GROUPS)'
> +
> +ifeq (y,$(CONFIG_FSTESTS_ENABLE_SOAK_DURATION))
> +FSTESTS_ARGS += fstests_soak_duration_enable='True'
> +endif
>  FSTESTS_ARGS += fstests_soak_duration='$(CONFIG_FSTESTS_SOAK_DURATION)'
>  
>  ifeq (y,$(CONFIG_FSTESTS_ENABLE_RUN_CUSTOM_TESTS))
> -- 
> 2.42.0
> 
> 
