Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6122C33A
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830185; cv=none; b=EArUnZW4StbnLT90MDpp83hTKgubr5DdgvaJJF4148GeZd7ZbJ4BzGM00HAv/dMxlcY+p23o86DxW1h1oLIudmr/QLC2GImPClHjnOaU7PwvoEz0XYIYalHlW7P7jHdIksZZju/B9PxiOBqaMul9Ei7ixf4+6eBu2ibUlw4WzVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830185; c=relaxed/simple;
	bh=nu4qvgTdpiNyVjtNdGfMo6mtUdbIckXpibWGIxnAm9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDOAC1BoQ1HRzYHnaNzxdNL2okA4H8/Tm82zKRahp8wD2L4aTgXbSI21NP8xh5n/TbuPZV3S3h00vHeS/bTLdExX2WVvKbchvqSqdyIfNFb0jQVJB90XXCk9mEOAfcxVMzDIunZsG6kHOJIkE/Oc3mbLgjvZfLzEtDQ+qjhypVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=vpA/Fyh+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="vpA/Fyh+"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74267c68c11so5840461b3a.0
        for <fstests@vger.kernel.org>; Wed, 21 May 2025 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747830183; x=1748434983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBrksEWrfoVCs8lIm9Io59n0dECdizkJ8M85wJvDY7A=;
        b=vpA/Fyh+9XFgwHl75B98//LYWiu+kPur33INbj+doFT7s/cpFRGj6OdWf+3GLHqzRN
         NB4YkeNLR7HyIB0kJq3UnyE9p7C7QsFwHxeynEE6ffcpXHPtTttnGnZrXJkeI8Y4OEFB
         pqQ313W3i5uM4N897vKOcowJ9DlvIJ94a3o/2XxRW1W8Kjlw6ohUIzQBCWgsFhfJpCHG
         hAvCtoxL775roezuJyE10GxdPVS3d58DzXWmEVcdcjQnXrdH7V5M4E7kFw8FSTijTOt1
         2Wk65BPlVla+5gm1yJXBVhu6WUnmE+6ueb6BuFZSNtO6bPKqAF1TRl81lm8bNIVBl2dk
         buqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747830183; x=1748434983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBrksEWrfoVCs8lIm9Io59n0dECdizkJ8M85wJvDY7A=;
        b=Qva+g3vXuZsSsvMlZXyBUgACIh9WpfYXyM4nFpK9uR6wv/WpejgCkMkRk0tMFNVoMc
         6xnf+oJEegQPv0tH2m03DOqNfygaezYbZdnR318ljb3aQJrp9rW3Iugh0r2guhFNszUV
         EITJZw5brUgdcFmITYwDPePp8XfAG1YDBVhR6w0ubBLxpv5gXchCu1IDDFNErWxJqKsr
         lobbIWRBKrXpk/hBx+476tr0wVBLekdrpAGn4M9TQuxWD3ZaYeTuXWFfgwJx/uSvkhjc
         QBGxsD9JAjS4vWwQkp800Pi5Z8s9SfB9Hn98fTxCPVsMrGAGbrGybmTYTWnNFEd2OYLo
         B5cg==
X-Gm-Message-State: AOJu0YzINBt41pfLOyHVTDYu/+3f6cRhNJ4Iv+5aOpX0YtXFKZJMarK4
	bGSoj2TXTHN//S7/L3Wm4J/B2NGfx8DSO6Cjc/Zs3FGAZ8wf5D9vlleKgIoJhvYWZqA=
X-Gm-Gg: ASbGncu1LRGuVgVXzWtEnJkTv+tt0l4/2mFVkFlrlRGnKAMiJt7eJSPAuzADdYDHoqu
	yWldqLH1icZ6vdvbRMVx0adbSud5IM4Gp1W6KP/KCXqZyUvvIs4rFnxtaqpQrKTWwiL2kEETX0E
	wWkgCVwmAcdwNO2m/Iu1mCAIFtC6QC+BWoShpmxQx8b7f0iO88OYwPzLAnyza9obRu/xZkW7ux+
	ONXIn0QJaOUICEsfdEHU22qimr3eRNJFK2NQgD6uemucMEks4gsKJGXrxvAXuzkDXMpe21MHsUr
	ynPCYtQjcFy3TbnjXqXNQhmsW6BDm11eka6dOlU8KEJXpS/ZENGLpi8u8YQ7CKbtC/fZ7NS5ZMz
	NLRrEpUfZPQ9aImi0XTo9eO4Ngx0=
X-Google-Smtp-Source: AGHT+IEVyS9e1Cixmz/rt1/7B2C0ciEl/CxTuHEXlm/2ZrEIKgyaNOyCM/TVomMCtwfbu1zaN2QZqg==
X-Received: by 2002:a17:90a:e70f:b0:2ff:5e4e:864 with SMTP id 98e67ed59e1d1-30e832162d4mr33159223a91.25.1747830183114;
        Wed, 21 May 2025 05:23:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365c4e77sm3515131a91.12.2025.05.21.05.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 05:23:02 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHiTM-00000006Iq0-0eAG;
	Wed, 21 May 2025 22:23:00 +1000
Date: Wed, 21 May 2025 22:23:00 +1000
From: Dave Chinner <david@fromorbit.com>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH 13/28] check-parallel: introduce config file support
Message-ID: <aC3FpDihoZzkuwhs@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-14-david@fromorbit.com>
 <077e031f6b6b179c9b5dabf284e3015c37dc3367.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <077e031f6b6b179c9b5dabf284e3015c37dc3367.camel@linux.ibm.com>

On Fri, May 09, 2025 at 05:31:49PM +0530, Nirjhar Roy wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > check-parallel will use the same config file format check does,
> > and use the same code to auto-discover the config file.
> > 
> > The biggest difference is that check-parallel -requires- the use
> > of config sections, and the first section *must* be named
> > "[check-parallel]". This first section is used for defining
> > setup parameters for check parallel - loop device image file sizes,
> > etc.
> > 
> > The second biggest difference is that check-parallel does not allow
> > the config file to define devices. Any section found to contain a
> > device definition such as TEST_DEV or SCRATCH_DEV will result
> > check-parallel terminating with an error.
> > 
> > This config file format works for check-parallel invoking check,
> > too, because once a section is specified on the check command line,
> > it effectively ignores unknown values set in sections that it
> > doesn't run.  Hence it effectively skips over the [check-parallel]
> > setup section.
> > 
> > For check-parallel, each config section now defines just the
> > filesystem configuration to be tested; all the usual mount and mkfs
> > options apply, and USE_EXTERNAL must be set for testing external
> > devices.
> > 
> > This commit implements the initial [check-parallel] section support
> > and moves the build in default values for these parameters to the
> > config file setup. This means if the config file does not contain
> > all the necessary parameter values, a default value will be used for
> > it.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
....

> > @@ -388,3 +408,51 @@ _config_section_setup()
> >  		fi
> >  	fi
> >  }
> > +
> > +# check-parallel config files must:
> > +# 1. have config sections defined
> > +# 2. use the first config section for check-parallel setup
> > +# 3. not define any physical device parameter in any section
> Nit: Maybe some documentation of the above restrictions and some new
> variables introduced (like SCRATCH_DEV_SIZE, ..)in the README?

Eventually, yes. Right now stuff is still in a state of flux, so
there is no point in adding extra documentation that has to be kept
up to date.

> > +# If all these are true, then we read the first section that defines
> > +# the check-parallel config parameters and continue onwards.
> > +_config_setup_parallel()
> > +{
> > +	if [ "$iam" != "check-parallel" ]; then
> > +		echo "$iam: incorrect config file format chosen!"
> > +		exit 1;
> > +	fi
> > +
> > +	_config_file_setup
> > +
> > +	if [ "$OPTIONS_HAVE_SECTIONS" != "true" ]; then
> Most of the places the way OPTIONS_HAVE_SECTIONS is being used is as 
> if $OPTIONS_HAVE_SECTIONS; then 
>     ...
> fi
> 
> so, when OPTIONS_HAVE_SECTIONS=true, /bin/true is executed and the exit
> code of /bin/true is always a success and it is not a string comparison
> with "true" or "false".

Yes, I know.

Executing /bin/true requires creating a new process just to return
a successful exit code. This takes several milliseconds of CPU time
to create and tear down a new process context.

OTOH, doing a string comparison in the shell parser takes a couple
of microseconds of CPU time....

Which is faster and burns less energy?

>
> /bin/true always succeeds and hence if
> OPTIONS_HAVE_SECTIONS=true, then 
> if $OPTIONS_HAVE_SECTIONS is always executed. In the same way
> /bin/false always has a failure code upon exit.
> So maybe we should change this to 
> if $OPTIONS_HAVE_SECTIONS; then - just to have consistency with the
> rest of the code?
> > +		echo "$iam config file has no sections!"
> > +		exit 1;
> > +	fi
> > +
> > +	local first_section=`echo $HOST_OPTIONS_SECTIONS | cut -f1 -d" "`
> > +	if [ "$first_section" != "$iam" ]; then
> > +		echo "$iam config file has no [$iam] section"
> > +		exit 1
> > +	fi
> > +
> > +	grep DEV $HOST_OPTIONS |grep -qv SIZE
> This will incorrectly fail the check-parallel invocation even if we
> have the devices defined in the comment section - so something like the
> following is causing a failure
> 
> local.config >>
> [check-parallel]
> TEST_DEV_SIZE=2G
> #TEST_DEV=/dev/loop0

Don't put devices in the check-parallel config file.

> Maybe we should try to ignore the lines that begin with '#'
> something like - grep -v '^[[:space:]]*#' $HOST_OPTIONS | grep DEV |
> grep -qv SIZE ? 
> 
> Another case:
> 
> Let us consider another local.config file:
> 
> [check-parallel]
> TEST_DEV_SIZE=2G
> 
> [xfs_4k]
> TEST_DEV=/dev/loop0
> TEST_DIR=/mnt1/test
> SCRATCH_DEV=/dev/loop1
> SCRATCH_MNT=/mnt1/scratch
> 
> The above file runs fine ./check -s xfs_4k selftest/001

Yes, but it is an invalid check-parallel config file because it has
devices defined in it.

If check-parallel allows this, then when it runs a check instance
it will override the environment defines set by the check-parallel
runner and every runner will try to use the same devices and mount
points.

It just doesn't work.

> However, with check-parallel, it will fail and it is expected according
> to the design. But is there any specific reason to fail when the above
> configuration is perfectly suitable to run check-parallel (we have
> check-parallel, section defined)? So 
> 
> ./check-parallel -s check-parralel -D /mnt1 -x stress -t 1 selftest/001
> check-parallel config file has devices defined
>
> Instead of grepping on the entire $HOST_OPTIONS, how about we only grep
> on the check-parallel section? In this way we parse/export the
> environment variables only in check-parallel section and ignore the
> sections that have devices defined and/or check-parallel incompatible.
> ./check -s xfs_4k works anyway with [check-parallel] section defined.
> ./check -s check-parallel will fail with *DEVs not defined which is
> self explanatory.

I think you may have misunderstood the direction check-parallel is
going in.

I don't want check and check-parallel to share the same config file.
What I need is for them to use the same file format and hence be
able to share parser code.

Later in the patchset I remove the dependency that check-parallel
has on check, and at that point the check-parallel config file no
longer needs to work with check.

However, there is an intermediate period in the patchset where
check-parallel calls check, and so the config file for
check-parallel has to be compatible with check for at least that
short period in time.

To make that work, the check-parallel config file cannot have any
devices or mount points defined anywhere in it, otherwise check will
override the values that check-parallel has provided via the
environment. We don't need to over-engineer this check - if there
are any known devices defined in the config file, abort.

If it gets a false positive, I don't care because once
check-parallel no longer calls check, the "no devices in
check-parallel config file" rule becomes irrelevant because the
config files are no longer shared. At this point the config file
supports only the subset of parameters that check-parallel defines
as valid, and no more. This set of valid parameters for
check-parallel will be enumerated in future patches.

Hence all we have to do at this point is make sure that the section
parser continues to work correctly for both test runners, not try to
invent the One True Config File To Rule Them All....

> > +	parse_config_section $1
> What value is $1 holding? _config_setup_parallel is being called only
> from check-parallel without any parameters passed, right? Did you mean
> _config_setup_parallel $first_section ?

Yup. Fixed.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
