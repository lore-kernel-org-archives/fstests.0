Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779F1FECB4
	for <fstests@vger.kernel.org>; Tue,  4 Mar 2025 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120992; cv=none; b=Cfv6oC55Lvj6xKoCZu0O2Qi4W8LjB0W247okOugaQ7GI0SexySk3mkHKp0hyhOVc/jfIyx/fYqH/75YDshfj7gH+D3uS9pkKvBCe5nm0TAmfTBJDL6XEvgkQwQzjTlWAfharHEnpnGTt6i/78d/fjcSSyrIqbymnTY0oalf3YTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120992; c=relaxed/simple;
	bh=0/bQCvnOYngt8Hc2Xc3NXjnW2c2U7fvhqODd5mLggK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTxgkW4zThIA1sjsg0Cc9EgCEZBILHhCxAq+uwM5IAuzPVf7wL0s7vr1BqX3gz94F6JbvgIbgDnFBi1W85j5YWA92GP+bKuQhTJPYOIaI0QXUlXgjO3PX5Ts/DmSkk7IrF1n1dzB0beOBnc6peSqiJsnNjJ0D4l+tcQijNUpomE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8uYUIsk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8uYUIsk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741120989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJvs7WI4apO+xJuW7xRH7x2h0PcMiho/Nz2/9/Af3a0=;
	b=M8uYUIskjl194kiKh06tvCbZPfQu2BP2xO4WiCOp5pTwpMaosi0QZBS1n4+/lgxvC73US9
	xez1iyWr4HoIJNkTEMgnShr9C8TknWWBcWFKHuvXuywu4YHTcpcR2qfAcJOTmtX5cplfqH
	ndP3oXwlH5UFQZ/YuEvEwviciPJQpd4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-8Y0Yc3KUOv-fNRsFOs__VA-1; Tue, 04 Mar 2025 15:43:08 -0500
X-MC-Unique: 8Y0Yc3KUOv-fNRsFOs__VA-1
X-Mimecast-MFC-AGG-ID: 8Y0Yc3KUOv-fNRsFOs__VA_1741120986
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2233b764fc8so107160835ad.3
        for <fstests@vger.kernel.org>; Tue, 04 Mar 2025 12:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741120986; x=1741725786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJvs7WI4apO+xJuW7xRH7x2h0PcMiho/Nz2/9/Af3a0=;
        b=lArdMYJSMPQoxuYgCrML4hPn45CNsf4VEHLhR0h5bnmq0GtlylnO1y6hCqhAxa2fgq
         YXDuB46PDzNHrVpXsDMcaF86rwdHu4w1GW2tlyjHXK/QM5T4UIQ58phaxZ91QJk0+n3j
         21DeCe39eeOkFawpXn6PGCQbhnjzHw439G30n2Hkbsqym/R4231BBXfIfkXu27RjZx7/
         CgXHE24qaeuMsekHfPB6xODDB8q4yzD5wMzDJ8o8z2eJrK05wpl2pY88Bj7baLOmjITc
         tmvcH5J77XX/aZla2MadwaV0tdgzlgnCIyX42qZm7fNDeBCJK0T3oqizjxmsk4xw14F4
         siug==
X-Forwarded-Encrypted: i=1; AJvYcCUGHblb4BfuQpGUjBJDj0GHTQkfo09Cm+B30tYxrS8kcSAvHAF7GzLyA3CEewyNLQeRzv2N/cnD@vger.kernel.org
X-Gm-Message-State: AOJu0YySCdwRw1Bay+gQFZU2hIpHmqSRG+/DtInr2tPDGNN6T3HuVIaV
	3tHlykjTzAGtrSy9rERYXDDbU9tdCY7vxeIhT1iCKt/kfLDhJTyl3dz5DxLX+28vp/5KUFjoHRF
	5qtAEn9A93YxzdkHba0vDM2WCc6pl754d8lqudrsbMRsOOw4gK/bAdOo=
X-Gm-Gg: ASbGnctgRZxhIA69kla/i/1+DGWLfCGABR8I/tdQDT0nRD5BhyZ6RD6csAA7rrST/Eb
	MoGRtm0Cxey1xpZEmM+YFjFyXD0IOee0gnAn2F0glwhKCwGYIwzivYKnoZWTwGeRfOPNhGSjHLV
	eeqcR295TpNiCzot/cuWYEFcuBEVg4aW6OhI3wIWYSEgCRIITXgNseZsAS6Eyy9TUhfaghjqfVr
	lyuMw+HNeBjwLKV/zlKmxbPjWh2Y6Mzp28+fSLiZE6S2zSV0wqa09eYxbtFY8p/F3yFG2TU9ma+
	hA/thQogvnIosPcZPY5BUBzVsxeuPumxCXEsqRu96r8pBoCi9mgHwklt
X-Received: by 2002:a17:902:e5d1:b0:223:245a:11e2 with SMTP id d9443c01a7336-223f1c6b24fmr7755345ad.6.1741120985818;
        Tue, 04 Mar 2025 12:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxlHxGqe0H8vCBsBqSVtJk/0rZb2EXz4ndjty+L5WWa1XuPlleV4F/gaczn3EDtXwJsvpL3A==
X-Received: by 2002:a17:902:e5d1:b0:223:245a:11e2 with SMTP id d9443c01a7336-223f1c6b24fmr7755065ad.6.1741120985387;
        Tue, 04 Mar 2025 12:43:05 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c09sm100163775ad.142.2025.03.04.12.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:43:04 -0800 (PST)
Date: Wed, 5 Mar 2025 04:43:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] check: disable HAVE_PRIVATENS by default
Message-ID: <20250304204301.6dbp4hijwaehxzqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250303205046.667838-1-zlang@kernel.org>
 <20250304200458.GA2803771@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304200458.GA2803771@frogsfrogsfrogs>

On Tue, Mar 04, 2025 at 12:04:58PM -0800, Darrick J. Wong wrote:
> On Tue, Mar 04, 2025 at 04:50:46AM +0800, Zorro Lang wrote:
> > Currently we have 3 ways to run a test case in _run_seq():
> > 
> >   if [ -n "${HAVE_PRIVATENS}" ]; then
> >       ./tools/run_privatens "./$seq"
> >       ...
> >   elif [ -n "${HAVE_SYSTEMD_SCOPES}" ]; then
> >       systemd-run --quiet --unit "${unit}" --scope \
> >              ./tools/run_setsid "./$seq" &
> >       ...
> >   else
> >       ./tools/run_setsid "./$seq" &
> >       ...
> >   fi
> > 
> > The "privatens" way brings in some regressions. We need more time
> > to develop and test this way, it's not time let it to be the
> > first default choice, so isolate the HAVE_PRIVATENS initialization
> > by a TRY_PRIVATENS parameter, and disable it by default.
> > 
> > Set TRY_PRIVATENS=yes to give "privatens" a try, otherwise run in
> > old ways. This patch can be removed after "privatens" way is stable.
> 
> I think it's ok to turn off privatens for now, seeing as it's clearly
> caused some regressions that I don't know how to fix.  The ones I know
> about are:
> 
> 1. The btrfs/14[01] use of BASHPID (not fixed)
> 2. The weird flock thing in generic/504 (fixed)

And a bug report when /tmp isn't a mount point.

> 
> But then there's a bunch more complaints about "everything" being
> broken.  If things are still broken for you, please send detailed dumps
> and let Zorro and I figure that out.
> 
> Note that run_privatens is a lot cleaner than run_setsid -- as I've
> stated elsewhere, using a new unix process session id to run a test is
> very messy -- there's no longer a controlling tty, so SIGSTOP doesn't
> work and SIGINT is masked by default.
> 
> As I suggested elsewhere today, maybe the solution is to have the tests
> that *require* the global pid namespace (anything calling the
> btrfs*read*mirror* helpers) turn themselves off with a
> "_require_non_privatens"; and then ./check can select setsid for any
> test containing that phrase.
> 
> Thoughts on this part?

More likes a trick, anyway I think we can talk about the way to fix btrfs
BASHPID related problems later. And I still don't know if it's the same
root cause with Dave Sterba hit.

> 
> --
> 
> I'm ok with taking the quickest route to something that makes everyone
> happy so that we can push to master again, and merge other peoples'
> changes because I bet those have been backing up for a while.
> 
> It's clearly time to talk about reorganizing who's responsible for
> reviews and for pushing git tree changes, and to take pressure off
> Zorro.  Anand has been signalling interest in taking on some of the
> btrfs workload, and I think that should happen in some form because
> Zorro and I are clearly outmatched.

Acutally I've tried to test most of major fs which fstests supports,
before a release. Btrfs testing is supported by my test scripts now.
Currently only default btrfs be tested. If Anand would like to test
more for btrfs before each release, I think that helps btrfs more.

> 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > Hi,
> > 
> > This patch aims to be talked. Refer to above commit log. This patch
> > is a workaround for 2 targets:
> > 1) Avoid the regressions of lastest xfstests release.
> > 2) Give us more time to improve the "privatens" method.
> > 
> > And compare with revert that commit directly, this patch trys to
> > give "privatens" method a chance to be enabled and tested (by
> > export TRY_PRIVATENS=yes).
> 
> Everyone else: do things work better if you manually patch out the
> run_privatens selection code so that run_setsid is always used?  The
> setsid code itself is also new; before that fstests just used killall.

If no one reports bugs to run_setsid, I'll think it's stable (temporarily),
then we'll pay more attention to "privatens".

> 
> > Thanks,
> > Zorro
> > 
> >  check | 22 +++++++---------------
> >  1 file changed, 7 insertions(+), 15 deletions(-)
> > 
> > diff --git a/check b/check
> > index ea92b0d62..33eb3e085 100755
> > --- a/check
> > +++ b/check
> > @@ -674,10 +674,13 @@ _stash_test_status() {
> >  	esac
> >  }
> >  
> > -# Can we run in a private pid/mount namespace?
> > -HAVE_PRIVATENS=
> > -./tools/run_privatens bash -c "exit 77"
> > -test $? -eq 77 && HAVE_PRIVATENS=yes
> > +# Don't try "privatens" by default, it's experimental for now.
> > +if [ "$TRY_PRIVATENS" = "yes" ];then
> > +	# Can we run in a private pid/mount namespace?
> > +	HAVE_PRIVATENS=
> > +	./tools/run_privatens bash -c "exit 77"
> > +	test $? -eq 77 && HAVE_PRIVATENS=yes
> > +fi
> >  # Can we run systemd scopes?
> >  HAVE_SYSTEMD_SCOPES=
> > @@ -692,15 +695,6 @@ function _adjust_oom_score() {
> >  }
> >  _adjust_oom_score -500
> >  
> > -warn_deprecated_sessionid()
> > -{
> > -	if [ -z "$WARNED_DEPRECATED_SESSIONID" ]; then
> > -		echo "WARNING: Running fstests without private pid/mount namespace"
> > -		echo "support is deprecated and will be removed in February 2026."
> > -		WARNED_DEPRECATED_SESSIONID=1
> > -	fi
> > -}
> > -
> >  # ...and make the tests themselves somewhat more attractive to it, so that if
> >  # the system runs out of memory it'll be the test that gets killed and not the
> >  # test framework.  The test is run in a separate process without any of our
> > @@ -900,8 +894,6 @@ function run_section()
> >  	seqres="$check"
> >  	_check_test_fs
> >  
> > -	test -n "$HAVE_PRIVATENS" || warn_deprecated_sessionid
> > -
> 
> Removal of the deprecation should be a separate patch, for which I will
> pre-offer a
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Ok, I'll splite this patch and send a v2. Thanks your reviewing!

Thanks,
Zorro

> 
> --D
> 
> >  	loop_status=()	# track rerun-on-failure state
> >  	local tc_status ix
> >  	local -a _list=( $list )
> > -- 
> > 2.47.1
> > 
> 

