Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA251C6FE4
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747799760; cv=none; b=FtJPVR3yTXh+nLPRsNNkvUW00WnUhVyUba0BvNucO3E56OC3Clf0Moc/S6xrl4oonQpA8eRBADB6uMsKPAa7eHDSQrbjnNMRuLcC698WxcS/mzgzAJjAjJEjnPtnWwnr3tIRSTCpGV2WWHtoOBbQ0KnACMV7gTsV5852Z/y0Bew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747799760; c=relaxed/simple;
	bh=TQb4nDlJ6s6Q2ivhErhzYlg28x1IEFA/GOhjyvysXZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmgZV0DuS5RbG9D1qYZUVfYdmpWsu0k50DprKEZct7OWmuMluXCeiTzsqt0dTIBQ1EQc5TUL6a7WYStWsbsi5Bna2UAZA1GBjXKCcc7l+OSn8ld1O7QqxuKcALF1qF1g7miYkf3s6lcpSeGEUrRsKNbjbe2ElY4mqg6YbmugYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=eOKSca3Q; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="eOKSca3Q"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2322dc5c989so21719025ad.3
        for <fstests@vger.kernel.org>; Tue, 20 May 2025 20:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747799758; x=1748404558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TadaIpYCLaeCq9faYfS7cPz65qrMgk89uzcsNPg9Dxo=;
        b=eOKSca3Q7NDSJ255yqhGq17MwAlinAiWvSFqGAcnTBMZHHcuIMm6plNWnDOaZv0SHK
         sRfLbeEIziPTIGaUi3e+b36JpAPQjefp1qe+W7LER7t5Y6uDKslAycR5uGPDwqDhNb83
         S/FCSLhV4huXQLPHUia7eUjTBqFUgQVpz/GawPVWQK7s6ZYOgLy3c20ew9tzWLCDm7+A
         mYIrSP3fW+RTSRWAvoWgroKj2Ow6K9t1b8KW2cxCGwRe5JAig7DCwhbUmdWG0MLGNBzD
         UjrTvPVuvUTugNumTNCrhifLyAItYT+ASrUq5jAkP9hw4cgRrwgis5wlKPWQ/QZx19hd
         7YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747799758; x=1748404558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TadaIpYCLaeCq9faYfS7cPz65qrMgk89uzcsNPg9Dxo=;
        b=gEidTxAVhZp7QNdD9I+x6vXgwq9ROhr5DElQJO8DNJDum3Wi2nijeip8SIb41m/9lE
         reLQ3ezTuHZQUUAK72P1a9Y+S9Hbwb7JS3vs5YYB3v3r2Ri2l3pFFrRfYyV6yvvY0P2D
         UGW8W1aCRoigMr6F5jrKH57P0x26nGWOJENEGa0R9cv4+EBp/F7mjU6ZPI3rFTmNCFGH
         GEq9zbyeMyyeLWuRtcoFyN7HSQCD37e3nmdnPSD1lg/6h0IffC+V3Jh20rlSg7dIJPb0
         d3KHvvb7tyJ9KuCV7lF0eIq4th8aw71XqwY+0hsyH4Bt5jHjwaOtyY6GnFewNb/dmgZL
         sOjQ==
X-Gm-Message-State: AOJu0Ywd+BklUxTOPeq28W+bVAUSHt1yDSbZPmd3aowyuYaND8dDsgnX
	/6w4h3uRg/GvG5wR3L9elCNdI7j2XBGW2nIn7MAVydsplxkL93kcHxBKVhMSGEPBUH0=
X-Gm-Gg: ASbGncuNVAP1wcf5TfHJflq3Y13PY2A2sYNqjWwRvJjsAaTO2INpK9s2Tcm2je0Utgr
	0T7juLLKmtAPsKc7WgYsRoYwS4DGiVrNaen6BT4UgJmcoHdcJY/HY9W7mguNO6s4FNeHpOS8EKA
	iqcL/Djbcc8jdpsmqACIIj8wbdftRE0zUD2VnAS8pzdTDzoZCCN8MYL6MBs17OmBG/BOo/Su8zS
	TMozjYmMcDb3Bx8p1L2OpvtILyixUP440AYhNvtdZrUxkgqvOSWWx/Y3DqDL/pnZx41hrs5Vmzg
	yLjahuDzA8ba7ielQX7WwmwICjaxj0in66Go3ujiWq3FxrO+W6ed8JUvq3K2aEPe8wTWpbHx3Cl
	O3OQ9qkhDdYyECBWxcuzQnIpYTQA=
X-Google-Smtp-Source: AGHT+IFXPF4roa91XvHVzUtQyYHJAYIm3RBXuhJohThSy/1KRl/WwjiRld5++PobpcHO7WF3FDr8ZQ==
X-Received: by 2002:a17:902:ec89:b0:224:93e:b5d7 with SMTP id d9443c01a7336-231de370eb9mr269134585ad.34.1747799757888;
        Tue, 20 May 2025 20:55:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adbfcbsm84445495ad.75.2025.05.20.20.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 20:55:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHaYc-00000006A00-2q1v;
	Wed, 21 May 2025 13:55:54 +1000
Date: Wed, 21 May 2025 13:55:54 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 05/28] check: factor out test list building code
Message-ID: <aC1Oym2XI_XuThUm@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-6-david@fromorbit.com>
 <3d2f07dc3291ab3e8a391e8909195a339240b16b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d2f07dc3291ab3e8a391e8909195a339240b16b.camel@gmail.com>

On Tue, May 06, 2025 at 05:02:54PM +0530, Nirjhar Roy (IBM) wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Factor out all the test list parsing and building code to
> > common/test_list so that it can be used by both check and
> > check-parallel.
> > 
> > This also namespaces all the test list code to use _tl_ prefixes,
> > and adds wrappers to set up test list parsing parameters.
> > 
> > Note: there is still some future work to convert externally visible
> > parameters like SRC_DIR to the new namespace.
> I have gone through this patch. I did some basic testing too with
> ./check and I havent' found any obvious issues. There are some minor
> feedback that I have given below:

Can you trim the stuff you aren't commenting on out? It makes it
much easier to find what you are commenting on....

....
> > diff --git a/common/test_list b/common/test_list
> > new file mode 100644
> > index 000000000..2432be6f7
> > --- /dev/null
> > +++ b/common/test_list
> > @@ -0,0 +1,295 @@
> > +##/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0+
> > +# Copyright (c) 2000-2002,2006 Silicon Graphics, Inc.  All Rights Reserved.
> > +# Copyright (c) 2024 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# Test list parsing and building functions
> > +#
> > +# Note: this file must stand alone and not be dependent on any other includes,
> We can include common/exit, right? That file doesn't file only has a
> couple of exit related functions (with no executable code) and no
> further dependencies, correct?

I wrote that before common/exit was really a thing.

As it is, I don't think we should be sourcing files from sourced
files. it hides all the dependencies, and results in the same file
being sourced multiple times in the same process context.

i.e. if the top level is doing:

. common/exit
.....
. common/test_list
.....

Then we don't need to source common/exit from common/test_list
because it already has been sourced.

That's what the comment is trying to say, and when I wrote it I was
specifically thinking about the mess that common/rc and
common/config was causing.


> > +# most especially common/rc and common/config. This is because we have to
> > +# include this file before option parsing, whilst the rc/config includes need to
> > +# be included -after- option parsing.
> > +#
> > +# Any function or variable that is public should have a "_tl_" prefix.
> > +
> > +export _tl_src_dir="tests"
> Minor: There was a change[1] which converted some of global variables
> in small case to upper case. Should we follow the same convention here,
> i.e, _TL_SRC_DIR or maybe _tl_SRC_DIR?

I don't think so, I very much dislike the semi-random capitalisation
of namespace-less variables across fstests. I find coe full of upper
case variables much more difficult to read and follow than properly
namespaced lower case variables.

That's the other thing that is important - lots of the global scope
variables sourced from common files are namespaceless and it makes
it easy easy for tests to accidentally step on such variables. Once
the varaibles are namespaced, there is no need for capitalisation
to indicate that it might be a global variable - the namespace
prefix tells you that as well as where it comes from.

> [1] 
> https://web.git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=ab459c67c5e0347ab4a5c28eadfe5ee4e3fd2f01

Yeah, that was a case of choosing your battles.

It wasn't a bug, but it was buried in a long series of bug fixes and
at the time people were shouting and being really obnoxious about
the check-parallel changes. There was no point in dying on an
unimportant hill by objecting to that change.

I still do think it was the wrong thing to do because it makes that
code be inconsistent with every other local file loop device
variable. Those devices are not used outside of common/metadump -
it is internal implemenation variable that the code was written
specifically to be hidden from callers wanting to manipulate and
test metadumps...

> > +_SRC_GROUPS="generic"
> > +_GROUP_LIST=
> > +_XGROUP_LIST=
> > +_tl_exact_order=false
> > +_tl_randomise=false
> > +_tl_have_test_args=false
> > +_tl_file="$tmp.test_list"
> > +_tl_exclude_tests=()
> > +_tl_tests=
> Similar comments for all the above lower cased global variables?

I didn't changed the GROUP names because they are internal to the
test list implementation. I was largely moving the code and didn't
want to change anything that was internal that I didn't need to
touch. I'll have a look at cleaning that up.

.....
> > +	# Specified groups to include
> > +	# Note that the CLI processing adds a leading space to the first group
> > +	# parameter, so we have to catch that here checking for "all"
> > +	if ! $_tl_have_test_args && [ "$_GROUP_LIST" == " all" ]; then
> > +		# no test numbers, do everything
> > +		get_all_tests
> > +	else
> > +		for group in $_GROUP_LIST; do
> > +			list=$(get_group_list $group)
> > +			if [ -z "$list" ]; then
> > +				echo "Group \"$group\" is empty or not defined?"
> > +				exit 1
> _fatal "Group \"$group\" is empty or not defined?" ?

Remember that this was posted before those changes were made. This is
the sort of thing that gets fixed on rebase...

> > +_tl_setup_exclude_group()
> > +{
> > +	local xgroup="$1"
> > +
> > +	_XGROUP_LIST="$_XGROUP_LIST ${xgroup//,/ }"
> > +}
> > +
> > +_tl_setup_group()
> > +{
> > +	local group="$1"
> Minor: Since this function is public , do you think it is helpful to
> have a quick sanitization that makes sure that $1 is not empty and
> prints message otherwise? Similar comment for
> _tl_setup_exclude_group(). 
> 
> > +
> > +	_GROUP_LIST="$_GROUP_LIST ${group//,/ }"
> > +}

I don't think it needs it. It should be checked by the caller
if necessary because it is the one doing option parsing to set up
the group.

> > +
> > +_tl_setup_cli()
> Nit: This function mostly sets up test list related variables - so
> maybe a name that suggests that. Maybe something like
> _tl_setup_test_list_vars or _tl_setup_test_vars - just a suggestion, no
> hard preferences here. 

Ok, I'll come up with a new name for it, but keep in mind that this
function is actually parsing arguments that have come directly from
the CLI.

> > +{
> > +	while [ $# -gt 0 ]; do
> > +		case "$1" in
> > +		-*)	echo "Arguments before tests, please!"
> > +			status=1
> > +			exit $status
> use _fatal?
> > +			;;
> > +		*)	# Expand test pattern (e.g. xfs/???, *fs/001)
> > +			local list=$(cd $_tl_src_dir; echo $1)
> > +			local t
> > +
> > +			for t in $list; do
> > +				t=${t#$_tl_src_dir/}
> > +				local test_dir=${t%%/*}
> > +				local test_name=${t##*/}
> > +				local group_file=$_tl_src_dir/$test_dir/group.list
> > +
> > +				if grep -Eq "^$test_name" $group_file; then
> > +					# in group file ... OK
> > +					echo $_tl_src_dir/$test_dir/$test_name \
> > +						>> $_tl_file
> > +					_tl_have_test_args=true
> > +				else
> > +					# oops
> > +					echo "$t - unknown test, ignored"
> Minor: Sometimes it has happened with me that I have added a new test
> (with ./new ) but forgot to run make and hence the test wasn't getting
> run and was reported to be an invalid test. Should we add a suggestion
> to run make, in case we encounter an unidentified test name?

Not in this patch set. If you want these sorts of process reminders,
please send them as separate feature additions.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
