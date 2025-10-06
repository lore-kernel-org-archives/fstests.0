Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F91F5825
	for <fstests@vger.kernel.org>; Mon,  6 Oct 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743511; cv=none; b=nFNZhn50RvNZhzZqW8pJO0GyqVN4O78YT1HBuGUsY7hX2fgXACmlgx5d2hEVZXT/5zLSqmU+Qx9KPEzF2Hk4ZCSsVA4D8wfE9aDLX296TR4euOf1hqKgFWl/PYIABzGaFxtabBvpGxr+ePwyKAXgi5AcldnHqy29cyCyeCJZx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743511; c=relaxed/simple;
	bh=xz/hZvzoakCriGkhB/bKuYdZ7YxI5bb7fHg5f/gAr14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx0kLRR2sgSg42Y1CyCseklqQuJMUJNedognN0QCHI6PMgWOxgxo2yWWt4bXeYOUHpU7OVPMPxpbGENm/teNppRtO1vHJHP8QUZ8WTObPbHy5az+jfXGP9O8OjKhanriBb6BCxeG9RiECE8dIWAwNEXwJaynNkuxWCP5yFRU0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvkIYx+O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvkIYx+O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759743508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wsVDhkH03OWQAuqDWfBRNCEFQGrTGPu8ofI2SiM2cKk=;
	b=RvkIYx+OGsz9McK+uIgc+q7D25+m0RBeNisOKf2fAzSZWCZpZBLkDTrFD07Ffcr5R9cw2A
	FB0SA9xLKFuX2CiZGOJliJrsVjjOpR5U7IPZ76yf3J9Imss3AE3fXoeT9q2T0Q4W9gR87R
	kFTy/Riz6yswcl7nr2tCPqpJ2u4/zsg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-oIF8sKpYMr2npepbJpekmg-1; Mon, 06 Oct 2025 05:38:26 -0400
X-MC-Unique: oIF8sKpYMr2npepbJpekmg-1
X-Mimecast-MFC-AGG-ID: oIF8sKpYMr2npepbJpekmg_1759743506
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso14454525e9.1
        for <fstests@vger.kernel.org>; Mon, 06 Oct 2025 02:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759743506; x=1760348306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsVDhkH03OWQAuqDWfBRNCEFQGrTGPu8ofI2SiM2cKk=;
        b=dMZmt7Oqos+bKlauXnh3CU1BrYH9J8pBWKzl59yfnOj8WDTSi3zuul8ImCnCmHgCXW
         9COQk4ZfF+wbWcsXThiZCxZ0zC7UpfDmPa/JJfdwZBJCHTbfBun8WMBzNU/ocrnkrKVT
         iRlnxkpnkwEp/zdWwCP0Gih4adSlccDGJQC4bbRO52QNc9jjuRcsD6HmcZ1lOJLaTjNn
         Q1HcondSksL7QAkuGW1tEuiecmSDCMVXSRrUjzPe06JrEsvtH/bp4apu8bPTnXRnA+kk
         QKXEjx2v8LxyIAv5tmxJ+vcEhEyc592bYNqvkjt0/AL+Upjn7VLYDM7VYDxekcrlnXwL
         M69A==
X-Gm-Message-State: AOJu0YwTSjV09ErR3ubJEVzWa25b5B/8RjuQQy91CVThVMh6Ju8R2IHw
	tj5N8slz9ZXxIiivyiea7hW/TE1mqNXWb4XBtDPIRyPTR68XoAphjcIY6ZKRs5Ykwmw8DVpWkIZ
	IcoVY2TvCqU6W28CWizil9EbpF8dgj9rB4kV9VQuIgT36caVP1gJ+LdcONA==
X-Gm-Gg: ASbGncvKIm9VWO7pY3R50wNOghdow5HyYDeIaS6aLP5SE/xDITLSrvj/K5oFOWpSyjx
	7I1IPDZWzA061EGOISg1NWzFRnSokJMj7+fCEh/R+ZeGucGwqjCxMP5qz3IMwEmMG/CG6MHxZEE
	gMawe9HKuTKz/T9Lr+9Gm6n5nrs3Ae50/0LXHypHc9TgpgGMKH5t8rjEPFhfl5hUpqVrNMPZpZw
	SO8WxwU37qQSRRKj9A9xGGc+Kazsa+Pqn9kJOQsXUpg3TfAAbC3NaXkpnd0Ls75Rpi9FhUQwFAb
	rl5Q8se9gZHxNr1GUZWUGU/XQgUf2EZCx8Qh093O7gA5tukI71CdWS9qY2Ui3ipWlg==
X-Received: by 2002:a05:600c:1f90:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-46e70cab483mr81343185e9.15.1759743505609;
        Mon, 06 Oct 2025 02:38:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlCYUUFPB4ex5CVbIn5iY3pHvG7kFW2Jjm67YSJUH6t7qfO2Y4261WpJcAoaKplrHvSbogkQ==
X-Received: by 2002:a05:600c:1f90:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-46e70cab483mr81342845e9.15.1759743504850;
        Mon, 06 Oct 2025 02:38:24 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bb2sm19624486f8f.10.2025.10.06.02.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 02:38:24 -0700 (PDT)
Date: Mon, 6 Oct 2025 11:37:53 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v4 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <7mytyiatnhgwplgda3cmiqq3hb7z6ulwgvwbkueb5dm2sdxwlg@ijti4d7vgrck>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
 <20251003-xattrat-syscall-v4-1-1cfe6411c05f@kernel.org>
 <20251005103656.5qu3lmjvlcjkwjx4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005103656.5qu3lmjvlcjkwjx4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On 2025-10-05 18:36:56, Zorro Lang wrote:
> On Fri, Oct 03, 2025 at 11:32:44AM +0200, Andrey Albershteyn wrote:
> > This programs uses newly introduced file_getattr and file_setattr
> > syscalls. This program is partially a test of invalid options. This will
> > be used further in the test.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> 
> [snap]
> 
> > +	if (!path1 && optind < argc)
> > +		path1 = argv[optind++];
> > +	if (!path2 && optind < argc)
> > +		path2 = argv[optind++];
> > +
> > +	if (at_fdcwd) {
> > +		fd = AT_FDCWD;
> > +		path = path1;
> > +	} else if (!path2) {
> > +		error = stat(path1, &status);
> > +		if (error) {
> > +			fprintf(stderr,
> > +"Can not get file status of %s: %s\n", path1, strerror(errno));
> > +			return error;
> > +		}
> > +
> > +		if (SPECIAL_FILE(status.st_mode)) {
> > +			fprintf(stderr,
> > +"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
> > +			return errno;
> > +		}
> > +
> > +		fd = open(path1, O_RDONLY);
> > +		if (fd == -1) {
> > +			fprintf(stderr, "Can not open %s: %s\n", path1,
> > +					strerror(errno));
> > +			return errno;
> > +		}
> > +	} else {
> > +		fd = open(path1, O_RDONLY);
> > +		if (fd == -1) {
> > +			fprintf(stderr, "Can not open %s: %s\n", path1,
> > +					strerror(errno));
> > +			return errno;
> > +		}
> > +		path = path2;
> > +	}
> > +
> > +	if (!path)
> > +		at_flags |= AT_EMPTY_PATH;
> > +
> > +	error = file_getattr(fd, path, &fsx, fa_size,
> > +			at_flags);
> > +	if (error) {
> > +		fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
> > +				strerror(errno));
> > +		return error;
> > +	}
> 
> We should have a _require_* helper to _notrun your generic and xfs test cases,
> when system doesn't support the file_getattr/setattr feature. Or we always hit
> something test errors like below on old system:
> 
>   +Can not get fsxattr on ./fifo: Operation not supported
> 
> Maybe check if the errno is "Operation not supported", or any better idea?

There's build system check for file_getattr/setattr syscalls, so if
they aren't in the kernel file_attr will not compile.

Then there's _require_test_program "file_attr" in the tests, so
these will not run if kernel doesn't have these syscalls.

However, for XFS for example, there's [1] and [2] which are
necessary for these tests to pass. 

So, there a few v6.17 kernels which would still run these tests but
fail for XFS (and still fails as these commits are in for-next now).

For other filesystems generic/ will also fail on newer kernels as it
requires similar modifications as in XFS to support changing file
attributes on special files.

I suppose it make sense for this test to fail for other fs which
don't implement changing file attributes on special files.
Otherwise, this test could be split into generic/ (file_get/setattr
on regular files) and xfs/ (file_get/setattr on special files).

What do you think?

[1]: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=8a221004fe5288b66503699a329a6b623be13f91
[2]: https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=0239bd9fa445a21def88f7e76fe6e0414b2a4da0

> 
> 
> Thanks,
> Zorro
> 
> > +	if (action) {
> > +		fsx.fa_xflags |= (fa_xflags | unknwon_fa_flag);
> > +
> > +		error = file_setattr(fd, path, &fsx, fa_size,
> > +				at_flags);
> > +		if (error) {
> > +			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
> > +					strerror(errno));
> > +			return error;
> > +		}
> > +	} else {
> > +		if (path2)
> > +			print_xflags(fsx.fa_xflags, 0, 1, path, 0, 1);
> > +		else
> > +			print_xflags(fsx.fa_xflags, 0, 1, path1, 0, 1);
> > +	}
> > +
> > +	return error;
> > +
> > +usage:
> > +	printf("Usage: %s [options]\n", argv[0]);
> > +	printf("Options:\n");
> > +	printf("\t--get, -g\t\tget filesystem inode attributes\n");
> > +	printf("\t--set, -s\t\tset filesystem inode attributes\n");
> > +	printf("\t--at-cwd, -a\t\topen file at current working directory\n");
> > +	printf("\t--no-follow, -n\t\tdon't follow symlinks\n");
> > +	printf("\t--set-nodump, -d\t\tset FS_XFLAG_NODUMP on an inode\n");
> > +	printf("\t--invalid-at, -i\t\tUse invalid AT_* flag\n");
> > +	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
> > +	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
> > +	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
> > +
> > +	return 1;
> > +}
> > 
> > -- 
> > 2.50.1
> > 
> 

-- 
- Andrey

