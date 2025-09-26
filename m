Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6919FA93
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901074; cv=none; b=GL2uXtecFzjW2znBQul8xNAl9KHgt+4wEPBms/53tZ9n7RFAY487pqmqUtEKU7aPmpO3DNtsJoz7D9V7AOHL3avfJRwCMAP8WB1we2j4SOXuzUrAVyvZUqi75sNzGc4olR17c/j37wHFOM/ULWVu45IBH3iqcFbQGSqBsV3svVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901074; c=relaxed/simple;
	bh=gqjjy4x7yRiMu8csQk8W7Fqdx8e8N4qT2tX/onlE3sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abMr/FNlvcfot9d9KVm7K0soAVN7TkOHgkLHv8dznwgT8ycjGtntK30ihQ+9z9wUY84oJdqCCzYTq+AaWr+DCLLbgunUpWPkQ4Q1cqZb9DSx1/2kyfGKRO+Bcr7a5b+aD+PcnEa96CTe9LOmaqHfzZPZNt8Uu/uiaeEQWRQ1bmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQvGDwox; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQvGDwox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758901071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NuJ1drhH6HCmU449hwtzxZyfclqHMgQnD+QVorNe8qc=;
	b=LQvGDwoxqA8upQecGnVK1jYLeIQOH1yPAoo9V+LGwBXd6Co6k8o3s+dmTRY6xLuPbb2245
	umbhwS9yqDZNrbo96jrEiXn8euP2M/aQilgigc/PlSpXPSgZSAyiziMMYtVpFF15Ltv0b6
	Ucnk4Uz8lq0AfPI+Cpus0qSYEx8bF84=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-or0hzUwFNfml2GZhBDPnjA-1; Fri, 26 Sep 2025 11:37:50 -0400
X-MC-Unique: or0hzUwFNfml2GZhBDPnjA-1
X-Mimecast-MFC-AGG-ID: or0hzUwFNfml2GZhBDPnjA_1758901069
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so2016641b3a.3
        for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 08:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758901069; x=1759505869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuJ1drhH6HCmU449hwtzxZyfclqHMgQnD+QVorNe8qc=;
        b=VfVPQeEQX2HUr5SY+i9rE76GcTfSxX5QNGV33BUPQBg93RYII48QCfod5GAvJscPVb
         du72mj5XhL1NB0Ym+lK7Y+ZlIKN0wqYHkQvpi0GqtIFlTOiOCarG849jjs7ueEgg1uML
         UMiFKuWMPVpW9pRwef6/TRw7CBT1DLoxO1m7TIlx6TQc1y8tfpUUUWsLHwnlTFdaETqH
         g0gqwNrTI4IiidsQ0cQPtaet4Y5tFwnRpq4Sid0ReyA39+i9D7MZ8ama7DjQ7jt40LAA
         kBRysMU38f9C+mQHJF7Do6Fy5xARkyqwKodwtSJlm60TR9NlVYoDUIIVy+pRTgRhNP6X
         AjEg==
X-Forwarded-Encrypted: i=1; AJvYcCV7hZ/k0FsnRNCPJNtQegEKnMiyUGkc6pG7lfeVvkZd9Nz/hFytqTL3iyQDsOlGpqOeBz9H2Qic@vger.kernel.org
X-Gm-Message-State: AOJu0YzuTMdVETUwdRVWeknzjtcaQ9Eu1tTfCGGbEfJrtMeZuZTlM6qy
	3buNwwgWZ78vQSmz+Xx9f98F9cGHJ/0Pqys9EHl5nvNfoY+pOy7A6QxqVDXBX9+1lt0hIyDpfxZ
	Cuzykk+8+zjMQbEBHWEBB+tHEQ5x0R3l9mdQAHEZNd+EvrlnawBLNO8wnWDM=
X-Gm-Gg: ASbGnctpIVU0cbBUto9A3Nw6hp7gD4NqmNHQburlEwHKAGq+g2I87Ig4/O0/C/fVuCI
	Z4LlsLDo2VdOFTPY+be7Ee5GnB5MLbgxiZGKl4C2UN+tdWQhsApSZqhx76MCDcIyZyja9wGWBd5
	Tnf31SheUwz7oCSl4osVXVB+ypkTB2+NrLqyQebhGxJfSzSF+NTXMJmpLA7WN0LgRj6+4Of5hA8
	8UB93oiRpRKGzcWGoz/NC1/pxiBHJqwsgW3zhdrycCdTazsY8vJiMR+8bGxnoJAfOyHrrw4xsMx
	9+SN+lKyDFA/VolOE5uc3dP7Fz96vytJCEE7WxFV4YlghNaH0lRqVFNlDC4Ux8T/Q5ZHXKDun1F
	5vFIH
X-Received: by 2002:a05:6a21:7e87:b0:2ec:4146:6a0f with SMTP id adf61e73a8af0-2ec41467f18mr7154927637.35.1758901068960;
        Fri, 26 Sep 2025 08:37:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc3Vr2SXRxWUrIPgMAtLDAtpeaOM03yRua4xmiTKc454FHwbWPteTYX79NE9EyV4pPkA1Usg==
X-Received: by 2002:a05:6a21:7e87:b0:2ec:4146:6a0f with SMTP id adf61e73a8af0-2ec41467f18mr7154900637.35.1758901068433;
        Fri, 26 Sep 2025 08:37:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c557493asm4972919a12.25.2025.09.26.08.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:37:48 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:37:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: cem@kernel.org
Cc: djwong@kernel.org, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 3/3] xfs/539: Remove test for good
Message-ID: <20250926153743.qzuafbnnarjynajo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250925093005.198090-1-cem@kernel.org>
 <20250925093005.198090-4-cem@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925093005.198090-4-cem@kernel.org>

On Thu, Sep 25, 2025 at 11:29:26AM +0200, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> This check deprecation warnings are not being printed during remount for
> both attr2 and ikeep mount options.
> 
> Both options are now gone in 6.17, so this test not only is pointless
> from 6.17 and above, but will always fail due the lack of these options.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  tests/xfs/539     | 72 -----------------------------------------------
>  tests/xfs/539.out |  2 --
>  2 files changed, 74 deletions(-)
>  delete mode 100755 tests/xfs/539
>  delete mode 100644 tests/xfs/539.out
> 
> diff --git a/tests/xfs/539 b/tests/xfs/539
> deleted file mode 100755
> index 5098be4a9351..000000000000
> --- a/tests/xfs/539
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2020 Red Hat, Inc.. All Rights Reserved.
> -#
> -# FS QA Test 539
> -#
> -# https://bugzilla.kernel.org/show_bug.cgi?id=211605

As the "attr2" and "ikeep" have been removed, so we don't need this bug
coverage either. I'm good to remove this.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> -# Verify that the warnings are not printed on remount if the mount option has
> -# the same value as during the mount
> -#
> -# Regression test for commit:
> -# 92cf7d36384b xfs: Skip repetitive warnings about mount options
> -
> -. ./common/preamble
> -_begin_fstest auto quick mount
> -
> -# Import common functions.
> -
> -_fixed_by_kernel_commit 92cf7d36384b \
> -	"xfs: Skip repetitive warnings about mount options"
> -
> -_require_check_dmesg
> -_require_scratch
> -
> -log_tag()
> -{
> -	echo "fstests $seqnum [tag]" > /dev/kmsg
> -}
> -
> -dmesg_since_test_tag()
> -{
> -	dmesg | tac | sed -ne "0,\#fstests $seqnum \[tag\]#p" | \
> -		tac
> -}
> -
> -check_dmesg_for_since_tag()
> -{
> -	dmesg_since_test_tag | grep -E -q "$1"
> -}
> -
> -echo "Silence is golden."
> -
> -# Skip old kernels that did not print the warning yet
> -log_tag
> -_scratch_mkfs > $seqres.full 2>&1
> -_scratch_mount -o attr2
> -_scratch_unmount
> -check_dmesg_for_since_tag "XFS: attr2 mount option is deprecated" || \
> -	_notrun "Deprecation warning are not printed at all."
> -
> -# Test mount with default options (attr2 and noikeep) and remount with
> -# 2 groups of options
> -# 1) the defaults (attr2, noikeep)
> -# 2) non defaults (noattr2, ikeep)
> -_scratch_mount
> -for VAR in {attr2,noikeep}; do
> -	log_tag
> -	_scratch_remount $VAR
> -	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated." && \
> -		echo "Should not be able to find deprecation warning for $VAR"
> -done
> -for VAR in {noattr2,ikeep}; do
> -	log_tag
> -	_scratch_remount $VAR >> $seqres.full 2>&1
> -	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
> -		echo "Could not find deprecation warning for $VAR"
> -done
> -_scratch_unmount
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/xfs/539.out b/tests/xfs/539.out
> deleted file mode 100644
> index 038993426333..000000000000
> --- a/tests/xfs/539.out
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -QA output created by 539
> -Silence is golden.
> -- 
> 2.51.0
> 

