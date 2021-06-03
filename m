Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA28C47096
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Jun 2021 16:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902896139A
	for <linux-fstests@archiver.kernel.org>; Thu,  3 Jun 2021 16:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFCQ1s (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 3 Jun 2021 12:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhFCQ1s (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 Jun 2021 12:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1AFA613F3;
        Thu,  3 Jun 2021 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622737563;
        bh=kjNKkFiLpTGKzT+vIPuG1gzsfZdZUN5YDzyz97MW3+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h2H+2+GWPYEisHZDrwAfn9yzTM2O4YOrJOwifk3WUPLI2fiCWllt922lV84U5NBjW
         LWUUekRBJtaVki/6EUp5rs538sNhP3Tpm0eoKjOInaafnpDDdcXXKpO+ufOzEpCMiF
         kNyIoSE8fvbH6QXfmHjntfMV9N/+fRHB4aKlzKyVP46nF78XsSWT9buhFgXclxVp72
         Be+dgiNTu/iEO9qWcD3O18uemNfr7SwXu4PXQ7E63HCQgGHRULAhuPJ6qUv+6puWnK
         MViVidVyK7gd0+dHi1V10XaLMws1+NkLu+K2fmLXn5KzXyCR5G/eOzNr8ZzZdWRMyc
         E5zzZ1v+V5lYg==
Date:   Thu, 3 Jun 2021 09:26:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add basic ftrace support
Message-ID: <20210603162603.GF26402@locust>
References: <20210601073133.194598-1-wqu@suse.com>
 <20210601164232.GA26402@locust>
 <fe305f9d-1583-f9ea-d87e-1522b252806d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe305f9d-1583-f9ea-d87e-1522b252806d@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 02, 2021 at 07:45:22AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/6/2 上午12:42, Darrick J. Wong wrote:
> > On Tue, Jun 01, 2021 at 03:31:33PM +0800, Qu Wenruo wrote:
> > > Sometimes developers want trace dump for certain test cases.
> > > 
> > > Normally I just add "trace-cmd" calls in "check", but it would be much
> > 
> > Heh, so do I!
> > 
> > > better to let fstests to support ftrace dumping.
> > > 
> > > This patchset will add basic ftrace dumping support by:
> > > 
> > > - Clear all buffers before running each test
> > > - Start tracing before running each test
> > > - End tracing after test finished
> > > - Copy the trace to "$seqres.trace" if needed
> > >    The condition is either:
> > >    * $KEEP_TRACE environment is set to "yes"
> > >    * The test case failed
> > > 
> > > Currently we only support the main ftrace buffer, but all supporting
> > > functions have support for ftrace instances, for later expansion.
> > 
> > I... did not know one could /have/ separate instances.
> 
> So did I, until I checked the code of "trace-cmd clear".
> 
> > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   check         | 12 +++++++-
> > >   common/ftrace | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > >   common/rc     |  1 +
> > >   3 files changed, 94 insertions(+), 1 deletion(-)
> > >   create mode 100644 common/ftrace
> > > 
> > > diff --git a/check b/check
> > > index ba192042..0a09dcf9 100755
> > > --- a/check
> > > +++ b/check
> > > @@ -801,7 +801,7 @@ function run_section()
> > >   		fi
> > >   		# really going to try and run this one
> > > -		rm -f $seqres.out.bad
> > > +		rm -f $seqres.out.bad $seqres.trace
> > >   		# check if we really should run it
> > >   		_expunge_test $seqnum
> > > @@ -839,6 +839,10 @@ function run_section()
> > >   		# to be reported for each test
> > >   		(echo 1 > $DEBUGFS_MNT/clear_warn_once) > /dev/null 2>&1
> > > +		# Clear previous trace and start new trace
> > > +		_clear_trace_buffers
> > > +		_start_trace
> > 
> > How do you actually turn on specific tracepoints?
> 
> Normally I use trace_printk(), thus no need to enable it manually.
> 
> > 
> > Or is the idea here to capture trace data for each test in a separate
> > file, and it's up to the ./check caller to set that up?
> 
> My idea is, it should be the QA guy to set it up.
> 
> Either using my stupid trace_printk() way, or enable those events before
> running the test.
> 
> > 
> > > +
> > >   		if [ "$DUMP_OUTPUT" = true ]; then
> > >   			_run_seq 2>&1 | tee $tmp.out
> > >   			# Because $? would get tee's return code
> > > @@ -848,6 +852,11 @@ function run_section()
> > >   			sts=$?
> > >   		fi
> > > +		_end_trace
> > > +		if [ "$KEEP_TRACE" == "yes" ]; then
> > > +			_copy_trace "$seqres.trace"
> > > +		fi
> > > +
> > >   		if [ -f core ]; then
> > >   			_dump_err_cont "[dumped core]"
> > >   			mv core $RESULT_BASE/$seqnum.core
> > > @@ -932,6 +941,7 @@ function run_section()
> > >   	# make sure we record the status of the last test we ran.
> > >   	if $err ; then
> > > +		_copy_trace "$seqres.trace"
> > >   		bad="$bad $seqnum"
> > >   		n_bad=`expr $n_bad + 1`
> > >   		tc_status="fail"
> > > diff --git a/common/ftrace b/common/ftrace
> > > new file mode 100644
> > > index 00000000..36886484
> > > --- /dev/null
> > > +++ b/common/ftrace
> > > @@ -0,0 +1,82 @@
> > > +#
> > > +# Common ftrace related functions
> > > +#
> > 
> > New file needs a SPDX header.
> 
> Oh, forgot that.
> 
> > 
> > > +
> > > +TRACE_DIR="/sys/kernel/debug/tracing"
> > > +
> > > +_clear_trace_buffers()
> > > +{
> > > +	if [ ! -d "${TRACE_DIR}" ]; then
> > > +		return
> > > +	fi
> > > +
> > > +	# Clear the main buffer
> > > +	echo 0 > "${TRACE_DIR}/trace"
> > 
> > If one were already running trace-cmd record, will this mess up its
> > ability to collect trace data?
> 
> I guess it may.
> 
> But that shouldn't be a problem, all existing buffers are before running the
> tests, thus should be considered as noise.

Yes, that's true for the first test run, but this clears the trace
buffers between every test.  If you start trace-cmd and run two tests,
isn't it possible that trace buffer content will be lost if trace-cmd
hasn't emptied the trace buffer when _clear_trace_buffers runs?

Alternate suggestion: Now that we know about the trace instance
functionality, what if the test runner passed a list of tracepoints to
./check?  Then ./check can set up a new tracing instance for itself with
the specified tracepoints, and we can clear the buffer before each test
and arrange to dump the contents to the trace file while the test runs.
That will have the added benefit of not messing with any other tracing
tools that might be running.

--D

> 
> > 
> > > +
> > > +	# Clear each instance buffer
> > > +	for i in $(ls "${TRACE_DIR}/instances"); do
> > > +		echo 0 > "${i}/trace"
> > > +	done
> > > +}
> > > +
> > > +_start_trace()
> > > +{
> > > +	instance=$1
> > 
> > local instance="$1", please don't pollute the caller's environment.
> 
> Oh, forgot it again...
> 
> > 
> > > +
> > > +	if [ ! -d "${TRACE_DIR}" ]; then
> > > +		return
> > > +	fi
> > > +
> > > +	if [ -z "${instance}" ]; then
> > > +		echo 1 > "${TRACE_DIR}/tracing_on"
> > > +	else
> > > +		mkdir -p "${TRACE_DIR}/instances/${instance}"
> > > +		echo 1 > "${TRACE_DIR}/instances/${instance}/tracing_on"
> > > +	fi
> > > +}
> > > +
> > > +_end_trace()
> > > +{
> > > +	instance=$1
> > > +
> > > +	if [ ! -d "${TRACE_DIR}" ]; then
> > > +		return
> > > +	fi
> > > +
> > > +	if [ -z "${instance}" ]; then
> > > +		echo 0 > "${TRACE_DIR}/tracing_on"
> > > +	else
> > > +		mkdir -p "${TRACE_DIR}/instances/${instance}"
> > 
> > Er, what's the logic here?  Ensure that the instance exist so that we
> > can disable it?
> 
> Oh, right, we should exit directly...
> 
> This part is copies from _start_trace() obviously...
> 
> Thanks,
> Qu
> > 
> > --D
> > 
> > > +		echo 0 > "${TRACE_DIR}/instances/${instance}/tracing_on"
> > > +	fi
> > > +}
> > > +
> > > +_remove_empty_trace()
> > > +{
> > > +	file="$1"
> > > +	if [ ! -f "$file" ]; then
> > > +		return
> > > +	fi
> > > +
> > > +	if [ -z "$(head -n 15 $file | sed '/^#/d')" ]; then
> > > +		rm $file
> > > +	fi
> > > +}
> > > +
> > > +_copy_trace()
> > > +{
> > > +	dest="$1"
> > > +	instance="$2"
> > > +
> > > +	if [ ! -d "${TRACE_DIR}" ]; then
> > > +		return
> > > +	fi
> > > +
> > > +	if [ -z "${instance}" ]; then
> > > +		cp "${TRACE_DIR}/trace" "$dest"
> > > +	elif [ -d "${TRACE_DIR}/instances/${instance}" ]; then
> > > +		cp "${TRACE_DIR}/instances/${instance}/trace" "$dest"
> > > +	fi
> > > +
> > > +	_remove_empty_trace "$dest"
> > > +}
> > > diff --git a/common/rc b/common/rc
> > > index 919028ef..f9de1517 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3,6 +3,7 @@
> > >   # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
> > >   . common/config
> > > +. common/ftrace
> > >   BC=$(which bc 2> /dev/null) || BC=
> > > -- 
> > > 2.31.1
> > > 
> > 
> 
