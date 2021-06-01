Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C520C47080
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 16:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DDD613BD
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Jun 2021 16:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhFAQoP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Jun 2021 12:44:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233904AbhFAQoO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Jun 2021 12:44:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D8AE613B6;
        Tue,  1 Jun 2021 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622565753;
        bh=Md8WMU/MNEjwYfMhk1VOT8Q1rFe12JmrNB/fEsxZr7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRakHgYpKmazMDkCxrgUxl82w6P/xqecvc6Kl9kg5dVzDS6kW/2AivNj4RMdlpcn9
         Dod6TQ4TUrufTvBd61K8vDmVwf/NiVf+jhI6g2TEZABnQXbY4VWEW8IoSwL8eSfiKe
         Ed6ufLPuuUYJPtb9XuzJ7EeQNQyjGLhyZIHFHHvaBUm8JDQoCNdqh8mfbgao6TJ8DF
         v2YvanErZq2TFlUet+DyRZ27VtD8NQyUqsl/z4MWXCHfEYyU9LWARdO93ojkTn0RAg
         xl4dWcvruZiE2xa9ub76MNdVqmhD1GySiWgOo1J5eYd92Abmb/KsPvd1/gDm3QUZSx
         DJ7h+UM3gbxyg==
Date:   Tue, 1 Jun 2021 09:42:32 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add basic ftrace support
Message-ID: <20210601164232.GA26402@locust>
References: <20210601073133.194598-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601073133.194598-1-wqu@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 01, 2021 at 03:31:33PM +0800, Qu Wenruo wrote:
> Sometimes developers want trace dump for certain test cases.
> 
> Normally I just add "trace-cmd" calls in "check", but it would be much

Heh, so do I!

> better to let fstests to support ftrace dumping.
> 
> This patchset will add basic ftrace dumping support by:
> 
> - Clear all buffers before running each test
> - Start tracing before running each test
> - End tracing after test finished
> - Copy the trace to "$seqres.trace" if needed
>   The condition is either:
>   * $KEEP_TRACE environment is set to "yes"
>   * The test case failed
> 
> Currently we only support the main ftrace buffer, but all supporting
> functions have support for ftrace instances, for later expansion.

I... did not know one could /have/ separate instances.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  check         | 12 +++++++-
>  common/ftrace | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  common/rc     |  1 +
>  3 files changed, 94 insertions(+), 1 deletion(-)
>  create mode 100644 common/ftrace
> 
> diff --git a/check b/check
> index ba192042..0a09dcf9 100755
> --- a/check
> +++ b/check
> @@ -801,7 +801,7 @@ function run_section()
>  		fi
>  
>  		# really going to try and run this one
> -		rm -f $seqres.out.bad
> +		rm -f $seqres.out.bad $seqres.trace
>  
>  		# check if we really should run it
>  		_expunge_test $seqnum
> @@ -839,6 +839,10 @@ function run_section()
>  		# to be reported for each test
>  		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
>  
> +		# Clear previous trace and start new trace
> +		_clear_trace_buffers
> +		_start_trace

How do you actually turn on specific tracepoints?

Or is the idea here to capture trace data for each test in a separate
file, and it's up to the ./check caller to set that up?

> +
>  		if [ "$DUMP_OUTPUT" = true ]; then
>  			_run_seq 2>&1 | tee $tmp.out
>  			# Because $? would get tee's return code
> @@ -848,6 +852,11 @@ function run_section()
>  			sts=$?
>  		fi
>  
> +		_end_trace
> +		if [ "$KEEP_TRACE" == "yes" ]; then
> +			_copy_trace "$seqres.trace"
> +		fi
> +
>  		if [ -f core ]; then
>  			_dump_err_cont "[dumped core]"
>  			mv core $RESULT_BASE/$seqnum.core
> @@ -932,6 +941,7 @@ function run_section()
>  
>  	# make sure we record the status of the last test we ran.
>  	if $err ; then
> +		_copy_trace "$seqres.trace"
>  		bad="$bad $seqnum"
>  		n_bad=`expr $n_bad + 1`
>  		tc_status="fail"
> diff --git a/common/ftrace b/common/ftrace
> new file mode 100644
> index 00000000..36886484
> --- /dev/null
> +++ b/common/ftrace
> @@ -0,0 +1,82 @@
> +#
> +# Common ftrace related functions
> +#

New file needs a SPDX header.

> +
> +TRACE_DIR="/sys/kernel/debug/tracing"
> +
> +_clear_trace_buffers()
> +{
> +	if [ ! -d "${TRACE_DIR}" ]; then
> +		return
> +	fi
> +
> +	# Clear the main buffer
> +	echo 0 > "${TRACE_DIR}/trace"

If one were already running trace-cmd record, will this mess up its
ability to collect trace data?

> +
> +	# Clear each instance buffer
> +	for i in $(ls "${TRACE_DIR}/instances"); do
> +		echo 0 > "${i}/trace"
> +	done
> +}
> +
> +_start_trace()
> +{
> +	instance=$1

local instance="$1", please don't pollute the caller's environment.

> +
> +	if [ ! -d "${TRACE_DIR}" ]; then
> +		return
> +	fi
> +
> +	if [ -z "${instance}" ]; then
> +		echo 1 > "${TRACE_DIR}/tracing_on"
> +	else
> +		mkdir -p "${TRACE_DIR}/instances/${instance}"
> +		echo 1 > "${TRACE_DIR}/instances/${instance}/tracing_on"
> +	fi
> +}
> +
> +_end_trace()
> +{
> +	instance=$1
> +
> +	if [ ! -d "${TRACE_DIR}" ]; then
> +		return
> +	fi
> +
> +	if [ -z "${instance}" ]; then
> +		echo 0 > "${TRACE_DIR}/tracing_on"
> +	else
> +		mkdir -p "${TRACE_DIR}/instances/${instance}"

Er, what's the logic here?  Ensure that the instance exist so that we
can disable it?

--D

> +		echo 0 > "${TRACE_DIR}/instances/${instance}/tracing_on"
> +	fi
> +}
> +
> +_remove_empty_trace()
> +{
> +	file="$1"
> +	if [ ! -f "$file" ]; then
> +		return
> +	fi
> +
> +	if [ -z "$(head -n 15 $file | sed '/^#/d')" ]; then
> +		rm $file
> +	fi
> +}
> +
> +_copy_trace()
> +{
> +	dest="$1"
> +	instance="$2"
> +
> +	if [ ! -d "${TRACE_DIR}" ]; then
> +		return
> +	fi
> +
> +	if [ -z "${instance}" ]; then
> +		cp "${TRACE_DIR}/trace" "$dest"
> +	elif [ -d "${TRACE_DIR}/instances/${instance}" ]; then
> +		cp "${TRACE_DIR}/instances/${instance}/trace" "$dest"
> +	fi
> +
> +	_remove_empty_trace "$dest"
> +}
> diff --git a/common/rc b/common/rc
> index 919028ef..f9de1517 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3,6 +3,7 @@
>  # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
>  
>  . common/config
> +. common/ftrace
>  
>  BC=$(which bc 2> /dev/null) || BC=
>  
> -- 
> 2.31.1
> 
