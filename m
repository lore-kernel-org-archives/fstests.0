Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C00228E8
	for <fstests@vger.kernel.org>; Sat, 11 May 2024 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715402812; cv=none; b=apreP+6dlZ6QkfA5eoxH0c+PCQ7L9XCUUv6uD1JDFW2b6eUfQw9sFzRHY/2FZNC0QxuZ8xJ3Q+r1h+Cd4E3hTiIZlqLTrZwykB0nhqEVuZ3XsBzvxVg75A7ZADWtlMhGAoAyR9vcO18Kktw+FU4QRQQVrWo4YyG/wF7cYv1TFGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715402812; c=relaxed/simple;
	bh=5lDQBrHOksT+PLObvsLnbL7EdOJIdgrcV0PGQReUJRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrnkG9mvRCUT8O/tRFsxOotf4fqzsrXGCuiWdY3wXWGWAsSUh1PKaE4z9nzmzP4j2CtVoqwKrOa0WUg4YCMspp5KL4BpHDeyhRI5aWRIq6JyVGhhRr4WndXrdLXGMLJLcv4zApnpkQL5SAtXbeUcIWNsBAR6ZnizGBMqaa/JSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EU/m2TvK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EU/m2TvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715402809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vkCye7QfvvCEPUA7QC8j976otbHjpmOxW5C07OawCHE=;
	b=EU/m2TvKNMukuC/QQdQLI7phDEnIU2wM/h23rZ1hOCFQdeHg4mp8/Od6bTKBlnNBOTzRt4
	aCLegavxe3ouQF5jlxLw5KhBFCcv2PoU7CR/4YPsl+APRovl95mMCVYdFZ6HgGg1i9bjZe
	azlYvsPJwpwXSbQXrkb2wXW+8XWBO8w=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-1XN8-ZAgP1qOH2w7klfGpw-1; Sat, 11 May 2024 00:46:47 -0400
X-MC-Unique: 1XN8-ZAgP1qOH2w7klfGpw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6f44e0a2756so2633987b3a.1
        for <fstests@vger.kernel.org>; Fri, 10 May 2024 21:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715402806; x=1716007606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkCye7QfvvCEPUA7QC8j976otbHjpmOxW5C07OawCHE=;
        b=KV518qF44JvbZtN28bi3HyWRRUgkgtuOaRXzQriyv8tlbpfPtqeoc+CyYM9n4UbLcf
         C7Ic2LfpiBdfUAuge8PICQVW01rQULI7dMRcR/uJmbyQLeQBWTOVIiTcdOExxPo5FTOg
         Efh8WyTr7qDjU7L320eswwFkF7LLGBgFGHg2vS8+XZo5lUHPpCRFVrI3iF620RJMkiRM
         ikYkLMiRMtO4i5XH5E0ag0zYuDU6LMu8l0WqarA1nVYxfHhCgHjfrdCZUXGTxxX7jmoF
         g2/CJVc6hdFok3sTW8/A0lKcRd0l6beqipWcjWKUWB1KpjpyE/uEM+EQK05/feqVNLfh
         8smg==
X-Forwarded-Encrypted: i=1; AJvYcCWeivE/JPPPiJWFl81z4sagy0jByCCfzBz61g7HJygIo/u/Z76OQ9M2yI5b/+tZ6TIg22wFQwVmOMoq25/G7zXH3MKcEiFxIg==
X-Gm-Message-State: AOJu0YyV2dwnYlNd26mwU5+F9gmpAEjnjWaLOhRoHAYPGKthbK5gq0Ke
	G2ETZvmaTHSmP4++CnpGoQs+1nH8HNk2Xkjq5n6gLnDb0INMUR2WksVOQrkTsnsmF20Hr2F2Scr
	9P7Q0n4zfwhcXhVQrgbV/Y+T8ZMU060j6QehrdyZXuTBNhlC/1juSlg8=
X-Received: by 2002:a05:6a00:198a:b0:6f4:4b84:7c17 with SMTP id d2e1a72fcca58-6f4c9338971mr10895890b3a.13.1715402805900;
        Fri, 10 May 2024 21:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq7h3zamdDLStvmlT1kdsGAawphlHPpe/ifNKbf7t+tZ2eVu2bR7AmmXUcDAopPkRfIroZpw==
X-Received: by 2002:a05:6a00:198a:b0:6f4:4b84:7c17 with SMTP id d2e1a72fcca58-6f4c9338971mr10895874b3a.13.1715402805294;
        Fri, 10 May 2024 21:46:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f9eesm3730726b3a.212.2024.05.10.21.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 21:46:44 -0700 (PDT)
Date: Sat, 11 May 2024 12:46:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/tracing: use /sys/kernel/tracing at first
Message-ID: <20240511044641.fgdvav54bxcw2wvj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240510043339.1238462-1-zlang@kernel.org>
 <20240510151754.GH360908@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510151754.GH360908@frogsfrogsfrogs>

On Fri, May 10, 2024 at 08:17:54AM -0700, Darrick J. Wong wrote:
> On Fri, May 10, 2024 at 12:33:39PM +0800, Zorro Lang wrote:
> > To avoid the dependence of debugfs, tracefs is mounted on another
> > place -- /sys/kernel/tracing now. But for the compatibility, the
> > /sys/kernel/debug/tracing is still there. So change _require_ftrace
> > helper, try to use the new /sys/kernel/tracing path at first, or
> > fallback to the old one if it's not supported.
> > 
> > xfs/499 uses ftrace, so call _require_ftrace in it.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  common/tracing | 13 +++++++++----
> >  tests/xfs/499  |  6 +++---
> >  2 files changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/common/tracing b/common/tracing
> > index b3051c27..8613d044 100644
> > --- a/common/tracing
> > +++ b/common/tracing
> > @@ -4,11 +4,16 @@
> >  #
> >  # Routines for dealing with ftrace (or any other tracing).
> >  
> > -FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances/"
> > -
> >  _require_ftrace() {
> > -	test -d "$FTRACE_INSTANCES_DIR" || \
> > -		_notrun "kernel does not support ftrace"
> > +	if [ -d /sys/kernel/tracing/instances/ ];then
> > +		FTRACE_ROOT="/sys/kernel/tracing"
> > +		FTRACE_INSTANCES_DIR="/sys/kernel/tracing/instances"
> 
> To answer my own question, this new path has been in Debian since at
> least 2021.

Oh, I thought the /sys/kernel/tracing was created in linux v4.1 :
  cc31004a4aa7 ("tracefs: Add directory /sys/kernel/tracing")

But might be used in different distro widely later.

> 
> > +	elif [ -d /sys/kernel/debug/tracing/instances/ ];then
> > +		FTRACE_ROOT="/sys/kernel/debug/tracing"
> > +		FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances"
> > +	else
> > +		_notrun "The ftrace is not supported, or tracefs is not mounted"
> > +	fi
> >  }
> >  
> >  _ftrace_cleanup() {
> > diff --git a/tests/xfs/499 b/tests/xfs/499
> > index 9672f95d..883415dc 100755
> > --- a/tests/xfs/499
> > +++ b/tests/xfs/499
> > @@ -14,18 +14,18 @@ _begin_fstest auto quick
> >  _register_cleanup "_cleanup" BUS
> >  
> >  # Import common functions.
> > +. ./common/tracing
> 
> You could probably get rid of the "Import common functions" comment.

Sure, will change that when I merge it.

> 
> This looks good!
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks,
Zorro

> 
> --D
> 
> >  
> >  # real QA test starts here
> >  _supported_fs xfs
> > +_require_ftrace
> >  _require_command "$CC_PROG" "cc"
> >  
> >  cprog=$tmp.ftrace.c
> >  oprog=$tmp.ftrace
> >  sedprog=$tmp.ftrace.sed
> >  
> > -ftrace_dir=$DEBUGFS_MNT/tracing/events/xfs
> > -
> > -test -d $ftrace_dir || _notrun "ftrace not enabled"
> > +ftrace_dir=$FTRACE_ROOT/events/xfs
> >  
> >  # The second argument to __print_symbolic is stringified in the tracepoint's
> >  # fmt file, so we look for "{ NUM, STRING }" and try to separate each of them
> > -- 
> > 2.44.0
> > 
> > 
> 

