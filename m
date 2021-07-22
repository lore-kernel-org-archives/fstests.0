Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0598C63793
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Jul 2021 09:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854F061019
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Jul 2021 09:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhGVImv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Jul 2021 04:42:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:38173 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231187AbhGVImu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 22 Jul 2021 04:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626945804;
        bh=b6R8sgRyXvYISRUX3a0zSEX2QjzIBEu0JptsI2505NI=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=JGi87uq1m9BBRNURlHmbc+Qe9z13nrVKCfH0nFMvusN1WFdIrRqXKPM201uR64Xxy
         /vCCEfJNny8Rbo0JgHuY1MZ8WE+dMMM6M7dxpxdqvJbU/VlqtQICro4M4j/UGAUC0x
         TrLwlUCPogZBNUbFbXAyyuk8ehNsBHrC7lazSIlM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYeR1-1lbzei0keB-00VfBP; Thu, 22
 Jul 2021 11:23:23 +0200
To:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
References: <20210722064725.3077558-1-david@fromorbit.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] [RFC] fstests: generic test hook infrastructure
Message-ID: <a8d305d5-010f-d8bc-bab0-e21b6463bcb9@gmx.com>
Date:   Thu, 22 Jul 2021 17:23:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722064725.3077558-1-david@fromorbit.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lBz7fEv20yYXfiNKolH3VBgDBsJnEvAffkRBMC/vzjQE99r+ZUb
 dv2sRR6qVHI5n/eBEFR2Zvd6qdx0FEs7kK0bpTCv4S6TdAZ+tRdpfnxWTSZRqwphrmlicHk
 AxJXmDiqtEznYmqPOKqq72E7LWuEpgDdaILLHYkQGhKs1kf00EFCuJzgGz5NXeeehWOOIRm
 2b99mHoSQsfTtZhdPANnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2V2XSB3Zkgc=:+BLFBGE6zj9lwDi529j2zv
 Q6UYn02ZSwmmiB0LoFTP+AwGl8zzc36CBi2IP8d1NUpqfHOcY0cOwb6AHvNo22u3u1H1oEHut
 wdiHMcbPHnXSPiuMEE/4ut1q923+LA7MWeDwtJfjL/a02h694tLaWFixVLJH/VZM2Fyn0783s
 So+wIH4C7FAeBLYH4yxQ6S8ilPuRhO/ilLSQ7v7CZ2Nh/lAZBzbyTmVjSqgzV8QDMP5+GadGt
 WB1//cDwXKTntiBOT0XTbqbeFvA+oEhEasrDIzhHUiOsEJZOY04TJOGKkmCcxIr/DQsxjs3d5
 /AQiSelNHdeTqDW/0klZsa61T02FhJUJJ9aku1rXPkadYEPfslIUeNYYhMrRz7v9Kms/zd993
 KdJwMeTvY5dMeLAZs5k4fN333taXM57T5MAA2VnF0Yzjkwbudd6KSh5tq0/38c+WNESuCXlW5
 0IIpN+lucElNflDoHmwbr5e+C+c0LmYs5RUHdCp6N2DhyXEWb9TZ4FWTU1lsQNt7wWZ0vCc89
 4lNShW0E9H5H7aPbLdsAk4N6Yn7yLa5PXRBVOC59At6E8hwq/kTREicUj5acltJL5JIms3qaL
 QomEotsKl1hy7JeL65buMQcoN6nUAFIynI3mcaKSr9ZEFupqur6wE/3IWyVJ6DDNhfovjok6E
 4sogkueo1q/gKc6KBihidift+wUdufG7eZNznYZUohwYKpFHGoKunZCsC3sn1UbtmjzXsBJvF
 yvtITgaGszRl/5+fh8Jf8o8ZWvSYFGrVgnp44BPdtDj8JLmyNs50NdfwztR3apxUroNB/6/j6
 9isIcjMuSg86zxZBJOiNNJb8KK68dUM8Crv0t0r2SoBA9NQVVwNFHA9NTdVnzKtjP3HqCWuCD
 aKyKU1qZ1tseN18ceTb/gKLFsK1oXZ3c/T/N4TX2AAkSQQ6Zd+vyERev2M1RUOXfk0/ST9hQd
 yiFuJpwaPJBZJJFcdZNpzbuUOnMgWb4t/S/KT4AKqnzgaphW+T1XQREBJilfu1cFePVw1qZvX
 aKPIgX5LhiASfwJwj9FIurQNRkFSeSafz5/PU/fPXjVos4NhsSupVUcsfyxQNhRHwbM4Jwen9
 lP70GTsx5u9OB+FmbzB6ScxaqNaR3y2eZm19IyM1Tslw/btXECM6g41kg==
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2021/7/22 =E4=B8=8B=E5=8D=882:47, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
>
> For discussion. This embodies the infrastructure I was suggesting
> here:
>
> https://lore.kernel.org/fstests/342381aa-9e1f-f81c-f0e4-a72f70f8ac48@sus=
e.com/T/#m8ff385bb5b8eab9ea5ed5fb45f253fda8b087fcf
>
> Essentially:
>
> hooks/start/generic-001.0
>
> will be run when generic/001 is set up but before the test starts.
>
> hooks/end/generic-001.0
>
> will be run when generic/001 _cleanup() is called but before any
> cleanup is done. i.e. we know if the test had a hard failure, but
> not whether there was a goldem image mismatch. Global hooks are
> named "global.N". The integer suffix is to allow multiple hooks to
> be stacked and ordered so we can combins simple hook scripts into
> much more complex monitoring setups without having to write a custom
> hook for every use case. e.g. a common trace-cmd hook to turn on
> trace_printk recording...
>
> In general, hooks/ is intended to contain symlinks to generic hooks
> scripts held elsewhere in the git tree.

Whether the hooks should be maintained by fstests is still debatable in
my opinion.

But at least it's not a big deal for now.

> That way we can have common
> hooks for doing things like turning tracing on and off, but only
> execute them for the tests we want to trace. The current curated
> hook scripts can be found in tests/Hooks. It is named with "H"
> because then the Makefile automatically skips it when generating
> group lists.
>
> The hook scripts run in the full test environment, so can _not_run
> and _fail tests.

This is what I actually want to avoid.

In fact, exposing the whole test environment itself is asking the hook
creators to be creative to exploit the fact (like overriding some
existing macros/environment/etc), and greatly increase the maintenance
burden.

As now hooks are at the same level of test cases, thus one just renaming
_not_run() would affect all the private hooks in the wild.


Thus I prefer to completely limit the access to the full environment.
A hook should only receive the minimal amount of info:

- Test number
- Hook specific temporary path
- Return value (for end hook)

And to allow a hook to terminate/end the test, we can require a super
simple check for the return value:

- 0 to continue
- Everything else to skip or terminate the test.
   Depends on the setting (the only extra setting for hook)
   With proper prompt of course.

   I originally considered the idea from Ted is the correct way to go,
   but I don't believe even developer would read the doc to know how to
   skip the test, then just go the super simple.

The less info a hook gets, the less maintenance burden.

But I'm not familiar enough with shell to allow a script to be executed
without inheriting any of the environment from its parent.
Thus no good idea on how to do that way.

> I've stopped them from outputting to stdout so they
> don't perturb golden image matches, but they can use $seqres.full
> easily enough. Indeed, the trace-cmd hooks I'm currenlty using write
> traces to $seqres.trace.dat and $seqres.trace.
>
> Yes, I'm actually using these hooks for trying to get a trace from a
> failure that is now occuring 1 in several hundred iterations of
> generic/482, and so I need the "-i <n>" based test iterations to
> restart the tracing at the start of every test. IOWs, a reason I
> was asking for Qu Wenro's basic infrastructure to be made more
> functional and usable.
>
> What else do people need these hooks to do?
>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>   .gitignore                          |   2 +
>   common/preamble                     | 104 +++++++++++++++++++++++++++-
>   tests/Hooks/trace-cmd-failure-stop  |  18 +++++
>   tests/Hooks/trace-cmd-start-xfs     |  11 +++
>   tests/Hooks/trace-cmd-start-xfs-log |  11 +++
>   tests/Hooks/trace-cmd-stop          |  14 ++++
>   tests/generic/482                   |  34 ++++-----
>   7 files changed, 177 insertions(+), 17 deletions(-)
>   create mode 100644 tests/Hooks/trace-cmd-failure-stop
>   create mode 100644 tests/Hooks/trace-cmd-start-xfs
>   create mode 100644 tests/Hooks/trace-cmd-start-xfs-log
>   create mode 100644 tests/Hooks/trace-cmd-stop
>
> diff --git a/.gitignore b/.gitignore
> index 2d72b064..c06cd6d8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -10,6 +10,7 @@ tags
>
>   /local.config
>   /results
> +/hooks
>
>   # autogenerated group files
>   /tests/*/group.list
> @@ -45,6 +46,7 @@ tags
>   # custom config files
>   /configs/*.config
>
> +
?

>   # ltp/ binaries
>   /ltp/aio-stress
>   /ltp/doio
> diff --git a/common/preamble b/common/preamble
> index 66b0ed05..7ef7d5b1 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -1,13 +1,114 @@
>   #!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: GPL-1.0

Why re-license?

>   # Copyright (c) 2021 Oracle.  All Rights Reserved.
> +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
>
>   # Boilerplate fstests functionality
>
> +# Hooks are scripts that are run at defined events within a test execut=
ion.
> +# The run in the test environment, so can interact with tests in intere=
sting
> +# ways.
> +#
> +# Start hooks are run once the test environment has been set up but bef=
ore
> +# the test execution starts.
> +#
> +# End hooks run from the cleanup function of the test but before any cl=
eanup
> +# action has been performed. Hence they have access to the entire state=
 of the
> +# test at exit and know whether the test has failed or not. Cleanup act=
ions will
> +# be run after the hook has completed.
> +#
> +# Hooks are implemented via a hook_execute() function in the hook scrip=
t. A hook
> +# without such a function will do nothing.

Again, a specific thing script writers need to learn.

I don't think just executing a bash script could be that different.
And it will need extra wrapping if one guy is running binary hooks.

Adding new restriction is just asking for more trouble in my opinion.

> +#
> +# The vector that executes the hook can be accessed from the hook scrip=
t via the
> +# $_hook varible. Tests never see this variable, or know that hooks exi=
st.
> +#
> +# Output from the hook script ends up in the test output file, so hooks=
 need to
> +# be silent on stdout otherwise they will cause test failures. Informat=
ion that
> +# hooks want to output should be directed to $seqres.full or there own
> +# $seqres.<type> output files. e.g. tracing output could be directed to
> +# $seqres.trace, raw trace files to $seqres.trace.dat, etc.
> +#
> +# Hooks can use _notrun and _fail to prevent a test from running or tri=
ggering a
> +# hard failure.
> +#

Should be in README.hooks, don't expect anyone to read things deep here,
especially linking preamble with hook is not that obvious.

> +_HOOKS_START=3D"$here/hooks/start"
> +_HOOKS_END=3D"$here/hooks/end"
> +_HOOKS_SRC=3D"$here/tests/hooks"
> +
> +_run_hook()
> +{
> +	local _hook=3D"$1"
> +
> +	. $_hook
> +	hook_execute >> $seqres.full 2>&1
> +}
> +
> +# For start hooks, we run global hooks first, per-test hooks last
> +#
> +# Per-test hooks are named "<type>-<name>" to reflect the structure of
> +# tests/<type>/<name>. e.g. xfs-001 is the hooks for the test in tests/=
xfs/001
> +_run_start_hooks()
> +{
> +	local n
> +	local name_arr
> +	local name
> +
> +	[ -d $_HOOKS_START ] || return
> +
> +	n=3D0
> +	while [ -e  $_HOOKS_START/global.$n ]; do
> +		_run_hook $_HOOKS_START/global.$n
> +		n=3D$((n + 1))
> +	done
> +
> +	# Convert the test name into a hook name. This converts the path name
> +	# to a space delimited array, and then uses reverse order indexing to
> +	# grab the last two elements of the array as the hook name. Hence
> +	# we end up with a name like xfs-001 from ..../tests/xfs/001
> +	name_arr=3D(${0//\//" "})
> +	name=3D"${name_arr[-2]}-${name_arr[-1]}"
> +
> +	n=3D0
> +	while [ -e $_HOOKS_START/$name.$n ]; do
> +		_run_hook $_HOOKS_START/$name.$n
> +		n=3D$((n + 1))
> +	done
> +}
> +
> +# For end hooks, we run per-test hooks first, global hooks last
> +#
> +# Per-test hooks are named "<type>-<name>" to reflect the structure of
> +# tests/<type>/<name>. e.g. xfs-001 is the hooks for the test in tests/=
xfs/001
> +_run_end_hooks()
> +{
> +	local n
> +	local name_arr
> +	local name
> +
> +	[ -d $_HOOKS_END ] || return
> +
> +	name_arr=3D(${0//\//" "})
> +	name=3D"${name_arr[-2]}-${name_arr[-1]}"
> +	n=3D0
> +	while [ -e $_HOOKS_END/$name.$n ]; do
> +		_run_hook $_HOOKS_END/$name.$n
> +		n=3D$((n + 1))
> +	done
> +
> +	n=3D0
> +	while [ -e $_HOOKS_END/global.$n ]; do
> +		_run_hook $_HOOKS_END/global.$n
> +		n=3D$((n + 1))
> +	done
> +}
> +
> +
>   # Standard cleanup function.  Individual tests can override this.
>   _cleanup()
>   {
>   	cd /
> +	_run_end_hooks
>   	rm -r -f $tmp.*
>   }
>
> @@ -60,4 +161,5 @@ _begin_fstest()
>   	# remove previous $seqres.full before test
>   	rm -f $seqres.full
>
> +	_run_start_hooks
>   }
> diff --git a/tests/Hooks/trace-cmd-failure-stop b/tests/Hooks/trace-cmd-=
failure-stop
> new file mode 100644
> index 00000000..cf5fae05
> --- /dev/null
> +++ b/tests/Hooks/trace-cmd-failure-stop
> @@ -0,0 +1,18 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> +#
> +# Basic trace-cmd stop hook to extract traces only on test failure. Thi=
s will
> +# not generate a trace if a golden image match fails, only if the test =
exits
> +# with a non-zero failure code.
> +#
> +# This will extract the current traces to $seqres.trace.dat, then stop =
the
> +# tracer. It will run a report on the trace data and drop it in $seqres=
/trace
> +hook_execute()
> +{
> +	echo Running hook $_hook
> +	if [ $status -ne 0 ]; then
> +		trace-cmd extract -o $seqres.trace.dat
> +		trace-cmd report -i $seqres.trace.dat > $seqres.trace
> +	fi
> +	trace-cmd reset
> +}
> diff --git a/tests/Hooks/trace-cmd-start-xfs b/tests/Hooks/trace-cmd-sta=
rt-xfs
> new file mode 100644
> index 00000000..90e484b1
> --- /dev/null
> +++ b/tests/Hooks/trace-cmd-start-xfs
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> +#
> +# trace-cmd start hook for tracing all XFS
> +#
> +# This is a memory hog - it reserves 250MB of RAM per CPU for the ring =
buffer.
> +hook_execute()
> +{
> +	echo Running hook $_hook
> +	trace-cmd start -b 250000 -e xfs\* -e xlog\*
> +}
> diff --git a/tests/Hooks/trace-cmd-start-xfs-log b/tests/Hooks/trace-cmd=
-start-xfs-log
> new file mode 100644
> index 00000000..886b707a
> --- /dev/null
> +++ b/tests/Hooks/trace-cmd-start-xfs-log
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> +#
> +# trace-cmd start hook for tracing XFS log events
> +#
> +# This is a memory hog - it reserves 250MB of RAM per CPU for the ring =
buffer.
> +hook_execute()
> +{
> +	echo Running hook $_hook
> +	trace-cmd start -b 250000 -e xfs_log\* -e xlog\*
> +}
> diff --git a/tests/Hooks/trace-cmd-stop b/tests/Hooks/trace-cmd-stop
> new file mode 100644
> index 00000000..402f40ff
> --- /dev/null
> +++ b/tests/Hooks/trace-cmd-stop
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> +#
> +# Basic trace-cmd stop hook
> +#
> +# This will extract the current traces to $seqres.trace.dat, then stop =
the
> +# tracer. It will run a report on the trace data and drop it in $seqres=
/trace
> +hook_execute()
> +{
> +	echo Running hook $_hook
> +	trace-cmd extract -o $seqres.trace.dat
> +	trace-cmd reset
> +	trace-cmd report -i $seqres.trace.dat > $seqres.trace
> +}
> diff --git a/tests/generic/482 b/tests/generic/482
> index 416b929a..9db464ba 100755
> --- a/tests/generic/482
> +++ b/tests/generic/482
> @@ -16,29 +16,31 @@ _begin_fstest auto metadata replay thin
>   # If debugging logwrites failures using the tools/dm-logwrite-replay s=
cript,
>   # switch the cleanup function to the version that is commented out bel=
ow so that
>   # failure leaves the corpse intact for post-mortem failure analysis.
> -_cleanup()
> -{
> -	cd /
> -	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
> -	_log_writes_cleanup &> /dev/null
> -	_dmthin_cleanup
> -	rm -f $tmp.*
> -}
> -
> -# tools/dm-logwrite-replay _cleanup version
>   #_cleanup()
>   #{
>   #	cd /
> +#	_run_end_hooks
>   #	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
> -#	if [ $status -eq 0 ]; then
> -#		_log_writes_cleanup &> /dev/null
> -#		_dmthin_cleanup
> -#	else
> -#		echo dm-thinvol-dev: $DMTHIN_VOL_DEV >> $seqres.full
> -#	fi
> +#	_log_writes_cleanup &> /dev/null
> +#	_dmthin_cleanup
>   #	rm -f $tmp.*
>   #}
>
> +# tools/dm-logwrite-replay _cleanup version
> +_cleanup()
> +{
> +	cd /
> +	_run_end_hooks
> +	$KILLALL_PROG -KILL -q $FSSTRESS_PROG &> /dev/null
> +	if [ $status -eq 0 ]; then
> +		_log_writes_cleanup &> /dev/null
> +		_dmthin_cleanup
> +	else
> +		echo dm-thinvol-dev: $DMTHIN_VOL_DEV >> $seqres.full
> +	fi
> +	rm -f $tmp.*
> +}
> +
>   # Import common functions.
>   . ./common/filter
>   . ./common/dmthin
>
