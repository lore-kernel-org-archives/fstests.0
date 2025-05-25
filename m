Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6BE1A08A6
	for <fstests@vger.kernel.org>; Sun, 25 May 2025 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748170157; cv=none; b=B0p21+C7iT8KYka0N8NlfxI9+pxyVH8ANO9JCf/lRl1MG0nD02QaImVS+BFpjWOcouQQLVDhiPkYlbS34+2n2nt3fyNlQVeNzypVEuzCPRrt+oTQfndkEbxX3m7FhE3by2LSPKrKpqH+yh9rt8ZGVuT64tRITGuoGdqnU4Jrvhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748170157; c=relaxed/simple;
	bh=fMsTsxceWIDjEEE58Qlav+biEOWyWAU3VNkqKqtOcEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4fzMaChuGtt84YAWP+DSZdBP6e7PN5A/5gR+azI9mRtgSgWlVZeeWOe6g3Ct6QWI7ETa00hEoG0aANOCjjXIDMlQumdYvmEWcSPM/fqJ9I4K5jtQVrIQxOtz1if9GCudru4XJLo2jmb6eYWEH/5MNNhDZ8OAxGAycokt/0yuXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVF7HtZG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVF7HtZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748170154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJ84WdnaKTRXymPrxlPombcUu50o2LKGI0cBQfuNosc=;
	b=hVF7HtZGBo8AsIgTLjg5Xi83YPmVtDkLM3ZMk0Xt7SB4oN0bxU7eoWfi2zzf0n+OgXdMi9
	rE2NFNuiqSkmS/kVBZcslbkxXCB//2XFRZc3xOX0bcVTJSqMZ4EV8sR1fzhgmTYJO5ravX
	MsInntIK4riBPYVpi71qRTZ3HSqCb6Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-Y4cH386_OVi8K_eg0a0e-g-1; Sun, 25 May 2025 06:49:13 -0400
X-MC-Unique: Y4cH386_OVi8K_eg0a0e-g-1
X-Mimecast-MFC-AGG-ID: Y4cH386_OVi8K_eg0a0e-g_1748170152
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2344f94f9e5so1215065ad.2
        for <fstests@vger.kernel.org>; Sun, 25 May 2025 03:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748170152; x=1748774952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ84WdnaKTRXymPrxlPombcUu50o2LKGI0cBQfuNosc=;
        b=laGl24K+g3mZInOIRZbl8DMtH+r8C+c5MWMRIG4KK1NnlZOTNdNHTXhzVUqoZXa9AH
         9M0CXd53XfIeKLYCMCHitJ1yPHOoO93Zkg78sgPrLW+DbhfRipMzjz/G1VijOHAyTX8F
         UGnEAG6tOIXC5MMvxiKoomeKlCC7pYJTPlJMnIeBnX6NCfRyR2loMf9i37OTL4ZAoodW
         wHJqsFCNMfZmeX4PqkenPa/qOOViZUtkDpQi4n4MQXj7j+1aJcsCHGYmQXfy6qA4VYQ+
         jqo1KrZcSOtuogwpKgmAOF6fNA9XWSmHap4x/dl770MAbFu/LmkUuSyluMTkfR4E8Eqp
         8LQw==
X-Forwarded-Encrypted: i=1; AJvYcCWSyZXYcuS1WNizXNBcGdSnCxKexgyphM/p9fIb9GwsmhIw01ziedGn/Mr6A+c+0MeI5FgHyaB8@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBRdZ5KNKkVD/ZINH1U7z4O75M4fjRoouZvVSlkGiqBzT49Kf
	1OxAoTWNR7gSY810tWl0Ctn+kkZ1GxnHlJWHwxHXqX8qMd7Ta3yrBbNX8ckKRszFjZwybK2Supn
	q0M1TH4Mqfndnu2L+VCdsUuPTmiulm0UXu+68UTBBABEgQgN1iOjQN9Sfk4c=
X-Gm-Gg: ASbGncuIy9MNRuri5h6b3qgCsfPUwy8YqptcmrgEqFBQytAu2RbI+JkjBQnFNFYVu02
	Vuz1stVNbG1cjMYXoAPiz5GiNq4YHyOJYgE5vxJYTVdClRl9SYyivyhHImRgu6ZTTMOTZW4L2ca
	GxmCJyPznvLdQ8uXNvL7IPYjc9XdwJcWmeL2L0y8X+cU6POsVHoWduKdw+/Hut8QaK8ghYtylDy
	mgCvW/c2ML6kOyWOpF4Ve5pym4k9N3CnIs+IJsX9haraHfELGnay2ZHW+j58qpL3Vr36mGO3Uku
	TYJXm89PvkHNo+TZ0HdovAsx58s+01G/amPAEqYuLCrQcsljY6N/
X-Received: by 2002:a17:902:e842:b0:22e:4a2e:8ae7 with SMTP id d9443c01a7336-23414f7d0ebmr98264775ad.22.1748170152100;
        Sun, 25 May 2025 03:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl/Vkjp7o36RBv/+MAmji1bFdSLGDh1AjMCmwCZ3Ds2i38mppqlK9uoC6KU9I6m5KbPBo5Ig==
X-Received: by 2002:a17:902:e842:b0:22e:4a2e:8ae7 with SMTP id d9443c01a7336-23414f7d0ebmr98264595ad.22.1748170151739;
        Sun, 25 May 2025 03:49:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2340c505ec8sm28282405ad.109.2025.05.25.03.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 03:49:11 -0700 (PDT)
Date: Sun, 25 May 2025 18:49:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] open_by_handle: add support for testing
 connectable file handles
Message-ID: <20250525104906.fnsphgcjvlzcl23z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250509170033.538130-1-amir73il@gmail.com>
 <20250509170033.538130-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509170033.538130-2-amir73il@gmail.com>

On Fri, May 09, 2025 at 07:00:32PM +0200, Amir Goldstein wrote:
> Test for kernel and filesystem support for conenctable file handles.
> 
> With -N flag, encode connectable file handles and fail the test if the
> kernel or filesystem do not support conenctable file handles.
> 
> Verify that decoding connectable file handles always results in a non
> empty path of the fd.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc            | 16 ++++++++++---
>  src/open_by_handle.c | 53 ++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 6592c835..6407b744 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3829,8 +3829,14 @@ _require_freeze()
>  }
>  
>  # Does NFS export work on this fs?
> -_require_exportfs()
> +_require_open_by_handle()
>  {
> +	local what="NFS export"
> +	local opts="$1"
> +	if [ "$1" == "-N" ]; then
> +		what="connectable file handles"
> +	fi
> +
>  	_require_test_program "open_by_handle"
>  
>  	# virtiofs doesn't support open_by_handle_at(2) yet, though the syscall
> @@ -3841,10 +3847,14 @@ _require_exportfs()
>  		_notrun "$FSTYP doesn't support open_by_handle_at(2)"
>  
>  	mkdir -p "$TEST_DIR"/exportfs_test
> -	$here/src/open_by_handle -c "$TEST_DIR"/exportfs_test 2>&1 \
> -		|| _notrun "$FSTYP does not support NFS export"
> +	$here/src/open_by_handle $opts -c "$TEST_DIR"/exportfs_test 2>&1 \
> +		|| _notrun "$FSTYP does not support $what"
>  }
>  
> +_require_exportfs()
> +{
> +	_require_open_by_handle
> +}
>  
>  # Does shutdown work on this fs?
>  _require_scratch_shutdown()
> diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> index a99cce4b..7b664201 100644
> --- a/src/open_by_handle.c
> +++ b/src/open_by_handle.c
> @@ -96,6 +96,9 @@ Examples:
>  #ifndef AT_HANDLE_MNT_ID_UNIQUE
>  #	define AT_HANDLE_MNT_ID_UNIQUE 0x001
>  #endif
> +#ifndef AT_HANDLE_CONNECTABLE
> +#	define AT_HANDLE_CONNECTABLE   0x002
> +#endif
>  
>  #define MAXFILES 1024
>  
> @@ -121,6 +124,7 @@ void usage(void)
>  	fprintf(stderr, "open_by_handle -d <test_dir> [N] - unlink test files and hardlinks, drop caches and try to open by handle\n");
>  	fprintf(stderr, "open_by_handle -m <test_dir> [N] - rename test files, drop caches and try to open by handle\n");
>  	fprintf(stderr, "open_by_handle -M <test_dir> [N] - do not silently skip the mount ID verifications\n");
> +	fprintf(stderr, "open_by_handle -N <test_dir> [N] - encode connectable file handles\n");
>  	fprintf(stderr, "open_by_handle -p <test_dir>     - create/delete and try to open by handle also test_dir itself\n");
>  	fprintf(stderr, "open_by_handle -i <handles_file> <test_dir> [N] - read test files handles from file and try to open by handle\n");
>  	fprintf(stderr, "open_by_handle -o <handles_file> <test_dir> [N] - get file handles of test files and write handles to file\n");
> @@ -130,14 +134,16 @@ void usage(void)
>  	fprintf(stderr, "open_by_handle -C <feature>      - check if <feature> is supported by the kernel.\n");
>  	fprintf(stderr, "  <feature> can be any of the following values:\n");
>  	fprintf(stderr, "  - AT_HANDLE_MNT_ID_UNIQUE\n");
> +	fprintf(stderr, "  - AT_HANDLE_CONNECTABLE\n");
>  	exit(EXIT_FAILURE);
>  }
>  
> -static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
> -				int bufsz, bool force_check_mountid)
> +static int do_name_to_handle_at(const char *fname, struct file_handle *fh, int bufsz,
> +				bool force_check_mountid, bool connectable)
>  {
>  	int ret;
>  	int mntid_short;
> +	int at_flags;
>  
>  	static bool skip_mntid, skip_mntid_unique;
>  
> @@ -181,18 +187,24 @@ static int do_name_to_handle_at(const char *fname, struct file_handle *fh,
>  		}
>  	}
>  
> +	at_flags = connectable ? AT_HANDLE_CONNECTABLE : 0;
>  	fh->handle_bytes = bufsz;
> -	ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
> +	ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, at_flags);
>  	if (bufsz < fh->handle_bytes) {
>  		/* Query the filesystem required bufsz and the file handle */
>  		if (ret != -1 || errno != EOVERFLOW) {
>  			fprintf(stderr, "%s: unexpected result from name_to_handle_at: %d (%m)\n", fname, ret);
>  			return EXIT_FAILURE;
>  		}
> -		ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, 0);
> +		ret = name_to_handle_at(AT_FDCWD, fname, fh, &mntid_short, at_flags);
>  	}
>  	if (ret < 0) {
> -		fprintf(stderr, "%s: name_to_handle: %m\n", fname);
> +		/* No filesystem support for encoding connectable file handles (e.g. overlayfs)? */
> +		if (connectable)
> +			fprintf(stderr, "%s: name_to_handle_at(AT_HANDLE_CONNECTABLE) not supported by %s\n",
> +					fname, errno == EINVAL ? "kernel" : "filesystem");
> +		else
> +			fprintf(stderr, "%s: name_to_handle: %m\n", fname);
>  		return EXIT_FAILURE;
>  	}
>  
> @@ -245,8 +257,17 @@ static int check_feature(const char *feature)
>  			return EXIT_FAILURE;
>  		}
>  		return 0;
> +	} else if (!strcmp(feature, "AT_HANDLE_CONNECTABLE")) {
> +		int ret = name_to_handle_at(AT_FDCWD, ".", NULL, NULL, AT_HANDLE_CONNECTABLE);
> +		/* If AT_HANDLE_CONNECTABLE is supported, we get EFAULT. */
> +		if (ret < 0 && errno == EINVAL) {
> +			fprintf(stderr, "name_to_handle_at(AT_HANDLE_CONNECTABLE) not supported by running kernel\n");
> +			return EXIT_FAILURE;
> +		}
> +		return 0;
>  	}
>  
> +
>  	fprintf(stderr, "unknown feature name '%s'\n", feature);
>  	return EXIT_FAILURE;
>  }
> @@ -270,13 +291,13 @@ int main(int argc, char **argv)
>  	int	create = 0, delete = 0, nlink = 1, move = 0;
>  	int	rd = 0, wr = 0, wrafter = 0, parent = 0;
>  	int	keepopen = 0, drop_caches = 1, sleep_loop = 0;
> -	int	force_check_mountid = 0;
> +	bool	force_check_mountid = 0, connectable = 0;
>  	int	bufsz = MAX_HANDLE_SZ;
>  
>  	if (argc < 2)
>  		usage();
>  
> -	while ((c = getopt(argc, argv, "cC:ludmMrwapknhi:o:sz")) != -1) {
> +	while ((c = getopt(argc, argv, "cC:ludmMNrwapknhi:o:sz")) != -1) {
>  		switch (c) {
>  		case 'c':
>  			create = 1;
> @@ -313,6 +334,9 @@ int main(int argc, char **argv)
>  		case 'M':
>  			force_check_mountid = 1;
>  			break;
> +		case 'N':
> +			connectable = 1;
> +			break;
>  		case 'p':
>  			parent = 1;
>  			break;
> @@ -445,7 +469,8 @@ int main(int argc, char **argv)
>  				return EXIT_FAILURE;
>  			}
>  		} else {
> -			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz, force_check_mountid);
> +			ret = do_name_to_handle_at(fname, &handle[i].fh, bufsz,
> +						   force_check_mountid, connectable);
>  			if (ret)
>  				return EXIT_FAILURE;
>  		}
> @@ -475,7 +500,8 @@ int main(int argc, char **argv)
>  				return EXIT_FAILURE;
>  			}
>  		} else {
> -			ret = do_name_to_handle_at(test_dir, &dir_handle.fh, bufsz, force_check_mountid);
> +			ret = do_name_to_handle_at(test_dir, &dir_handle.fh, bufsz,
> +						   force_check_mountid, connectable);
>  			if (ret)
>  				return EXIT_FAILURE;
>  		}
> @@ -589,6 +615,15 @@ int main(int argc, char **argv)
>  		errno = 0;
>  		fd = open_by_handle_at(mount_fd, &handle[i].fh, wrafter ? O_RDWR : O_RDONLY);
>  		if ((nlink || keepopen) && fd >= 0) {
> +			char linkname[PATH_MAX];
> +			char procname[64];
> +			sprintf(procname, "/proc/self/fd/%i", fd);
> +			int n = readlink(procname, linkname, PATH_MAX);
> +
> +			/* check that fd is "connected" - that is has a non empty path */
> +			if (connectable && n <= 1) {
> +				printf("open_by_handle(%s) returned a disconnected fd!\n", fname);
> +			}
>  			if (rd) {
>  				char buf[4] = {0};
>  				int size = read(fd, buf, 4);
> -- 
> 2.34.1
> 

