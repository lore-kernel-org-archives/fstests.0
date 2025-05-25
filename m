Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B479A1487ED
	for <fstests@vger.kernel.org>; Sun, 25 May 2025 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748170193; cv=none; b=hQX3iVNuxP8BQLn08ZkmX0AiriN9G4r0/ckREXZExhXu0iSRrO6cad0ig74+6LWZb+P2sY/QD79tEkSbuDX+kgzY0/EKLNE2kfbYAskQUk2sD/RJvgF/qIZCmoeVGoRdjw3p2tj43B+JTiddx8c1nuMffnWIORzVJDSl8wJM2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748170193; c=relaxed/simple;
	bh=7yKbTv3gj8ctU0b67nCBA69euCAu2svDUYEd+GFonl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jf+d9IfNQ7JI6YcEqLoW8IItduxcL7xXCwR/CD/4Tcme2w02gGzFrMX+bXNxdrRyf0pbQiGUc/VQyXmGPhg8o7kr2eE8c/Eh1Nd6tHFCa+rKpkc0JTwZk00g8tvqqC0/UZbMzg4pqc6PzAjlvauZfFerYNZESeh5IcahBWspBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctCLdNaC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctCLdNaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748170190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Uz/E9IWdMOFr6BicHH50vsyvsKiWajN3DhCKTVNub3k=;
	b=ctCLdNaCf4JPGblcM+vLmATU8Tg8yO8tvZHsdyd5Izxy7PUhQqRNFd+j1L4Bct65etXvRA
	U49Bzqe21lptvmLiiWLPenJE3FP4nM2PHtsNRyou4/dykkROuS6Or36QsfzEpWRpEzjrAU
	M9IGVKO6wp1f87QVEqkBDjrIeW2+LxE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-gCguIjKQOFmEAUj94vXHWg-1; Sun, 25 May 2025 06:49:48 -0400
X-MC-Unique: gCguIjKQOFmEAUj94vXHWg-1
X-Mimecast-MFC-AGG-ID: gCguIjKQOFmEAUj94vXHWg_1748170188
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22de54b0b97so10037375ad.2
        for <fstests@vger.kernel.org>; Sun, 25 May 2025 03:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748170188; x=1748774988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uz/E9IWdMOFr6BicHH50vsyvsKiWajN3DhCKTVNub3k=;
        b=P2u3iROs9T2XomQ0fmhO6YaplRIjKpjs9Hz0XmPQ8lpv+IiTIO6XbtzwQnK+u213Zu
         kcPeZAZF/b/7oeWHg5DgIU4XhpCAGB0OgICEySHaJu9VV8O/jtkMz4v347IvZSWr1QDG
         qbS/Nd7RyJFqmQUf8jrZ0EpnEzfWBwi75OaY/NX4oT6ZU9+HnAMdefrG0Iakxr6diauU
         yM7I97oI7ZGXRoHdfn2U82tJrVCwQ5IODvwIjw7duCi5611hECtc5XnVlZkuxf09sA18
         LMogEdE1uxsUNPlHy4FD4fagi1H/2OKsA170Gl25eOIlzTHkc7kAhR/ay5D5MWPc3pZ6
         K5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWPlQKfQJI9dWbPXbyO1+9zmDhUX+o35TKyzPUG4MosPjML9UtlWKrp88mx/Dh11oJhYr4hiwi6@vger.kernel.org
X-Gm-Message-State: AOJu0YzZeEhynx7Pwvr7kw/s7sSNY4GPZGhN5nl0gPlyvcmf7EePckC/
	Wyt4iOvi4QkwgmypkkWl4vXNAyAzTDuIfq39GECTcg6lRl0DVilrdHULGQjiYGKwVDb7RfuIa/5
	w3j7uot1HI/MvL8HPa8nZFd8YY5jkUhp2qHhHSkwVrR4SkHuenVuE+ypeYeY=
X-Gm-Gg: ASbGncte0TXaHndQ1xu8fftN6tun57/xJzov55Epyj6Ds4OR9r5UQ+OspeOwDU1s6Cu
	8P3taM7sTt6OWR8pqdrmNlVvo0N3+x+/N7WlOn7Ym158xOdBidKTFBSdrq6Jfzwzd3FI/7bJhOo
	1aiFZz5DLZzUQ0xgyFzQA/TiLFxlwBxooXFfL4g1oWNsUCwSILCGXgjWp8kRuYET6kfq17OpaWc
	B62ETTcobab9QRep3LEA2dQ0kilSFYvKzx9pefcgncQLZlG6MiJRKqk79MEvALYQL+hcRxAPlbd
	JDoB6uN6iP9j0XsxiU+bYKOK/y4fDSQl35gUHjkoC2v/Hw19PLYX
X-Received: by 2002:a17:903:19f0:b0:224:10a2:cae7 with SMTP id d9443c01a7336-23414fb2509mr97440545ad.40.1748170187723;
        Sun, 25 May 2025 03:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfbENn2ZeSNx6g8fBNFmQvjshZpRLDgWWDXIFrUQuZkXZ5Jj1/il0RzWBUhU4fO9SKEuFn9w==
X-Received: by 2002:a17:903:19f0:b0:224:10a2:cae7 with SMTP id d9443c01a7336-23414fb2509mr97440425ad.40.1748170187359;
        Sun, 25 May 2025 03:49:47 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23445ee77c8sm8451705ad.127.2025.05.25.03.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 03:49:47 -0700 (PDT)
Date: Sun, 25 May 2025 18:49:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 2/2] open_by_handle: add a test for connectable
 file handles
Message-ID: <20250525104942.v66gb6kekfmwlbtp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250509170456.538501-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509170456.538501-1-amir73il@gmail.com>

On Fri, May 09, 2025 at 07:04:56PM +0200, Amir Goldstein wrote:
> This is a variant of generic/477 with connectable file handles.
> This test uses load and store of file handles from a temp file to test
> decoding connectable file handles after cycle mount and after renames.
> 
> Decoding connectable file handles after being moved to a new parent
> is expected to fail on some filesystems, but not on filesystems that
> do not really get unmounted in mount cycle like tmpfs, so skip this test.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/777     | 70 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/777.out |  4 +++
>  2 files changed, 74 insertions(+)
>  create mode 100755 tests/generic/777
>  create mode 100644 tests/generic/777.out
> 
> diff --git a/tests/generic/777 b/tests/generic/777
> new file mode 100755
> index 00000000..d8d33e55
> --- /dev/null
> +++ b/tests/generic/777
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2018-2025 CTERA Networks. All Rights Reserved.
> +#
> +# FS QA Test No. 777
> +#
> +# Check open by connectable file handle after cycle mount.
> +#
> +# This is a variant of test 477 with connectable file handles.
> +# This test uses load and store of file handles from a temp file to test
> +# decoding file handles after cycle mount and after directory renames.
> +# Decoding connectable file handles after being moved to a new parent
> +# is expected to fail on some filesystems, but not on filesystems that
> +# do not really get unmounted in mount cycle like tmpfs, so skip this test.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick exportfs
> +
> +# Import common functions.
> +. ./common/filter
> +
> +
> +# Modify as appropriate.
> +_require_test
> +# Require connectable file handles support
> +_require_open_by_handle -N
> +
> +NUMFILES=10
> +testroot=$TEST_DIR/$seq-dir
> +testdir=$testroot/testdir
> +
> +# Create test dir and test files, encode connectable file handles and store to tmp file
> +create_test_files()
> +{
> +	rm -rf $testdir
> +	mkdir -p $testdir
> +	$here/src/open_by_handle -N -cwp -o $tmp.handles_file $testdir $NUMFILES
> +}
> +
> +# Decode connectable file handles loaded from tmp file
> +test_file_handles()
> +{
> +	local opt=$1
> +	local when=$2
> +
> +	echo test_file_handles after $when
> +	$here/src/open_by_handle $opt -i $tmp.handles_file $TEST_DIR $NUMFILES
> +}
> +
> +# Decode file handles of files/dir after cycle mount
> +create_test_files
> +_test_cycle_mount
> +test_file_handles -rp "cycle mount"
> +
> +# Decode file handles of files/dir after rename of parent and cycle mount
> +create_test_files $testdir
> +rm -rf $testdir.renamed
> +mv $testdir $testdir.renamed/
> +_test_cycle_mount
> +test_file_handles -rp "rename parent"
> +
> +# Decode file handles of files/dir after rename of grandparent and cycle mount
> +create_test_files $testdir
> +rm -rf $testroot.renamed
> +mv $testroot $testroot.renamed/
> +_test_cycle_mount
> +test_file_handles -rp "rename grandparent"
> +
> +status=0
> +exit
> diff --git a/tests/generic/777.out b/tests/generic/777.out
> new file mode 100644
> index 00000000..f2dd33c3
> --- /dev/null
> +++ b/tests/generic/777.out
> @@ -0,0 +1,4 @@
> +QA output created by 777
> +test_file_handles after cycle mount
> +test_file_handles after rename parent
> +test_file_handles after rename grandparent
> -- 
> 2.34.1
> 

