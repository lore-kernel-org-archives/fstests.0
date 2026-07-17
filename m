Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD342A158;
	Fri, 17 Jul 2026 16:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305204; cv=none; b=QVqG2w9z2Nv3+ItDtnZiOPb/JUV/qGVSeiHMcs5tJfiTZvx7ENjuMs26FHliDsZoPozHHCf5h9rNUwqmxrM/A4rqfLhPS4DbFj2mNrEVJp8sJAHYu7hEol/uWIKUXs15kASbpbGEa28Pf45d5ahfNZgq1sGrowJdMjO6Ly562c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305204; c=relaxed/simple;
	bh=gwYYfaBPvkkdTBEGfghTg5/RzhaRVi35iovpcnmw8Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEP5ML4+2aS5Ahxr+2Nue53qqOf9Od0rQJrrV8ZhLY4/kkPtLky3o8/tD72WYAVJoZOjVliLNxm9Dis+Yk3e1GniA3r6TQCo9IVRdsDITtRTKFKdo2jVSzdkta4TrFEkUQIT/SenhCO8ioLu8BEncxWw6D28fZ4fIziaWHG//sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSVzyISa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSVzyISa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF4D1F000E9;
	Fri, 17 Jul 2026 16:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784305202;
	bh=mXxuUX6egP3L+HigzQLjcN5r+sZSo1AI07VgYToFH78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QSVzyISandzbX11SbK+wAkXqDYi025m2IT0UbMBA734fAHH16Fb1IotN6DwmnZpet
	 L2Ii24RIwTRAYL7ut8RJYizGtszcGzWE4TpVf/8uH9OCuHyEyj2eklOlFzS524/ZYo
	 wfI3a1A8Uj8gaP29CCOtHeI669ofDi0mtUsg0cnbxAYeywvz7/xvtJTC6SqWK9p9PN
	 H16LWMD5ZdYBHLwEDiMZZtOP3FjFlLvcYa/MIIHn5kJKHLiHLs8f+4iauVT1ziZq6x
	 m7djRh73b9pIwT9+A+FuVT1ZxVCT2Y/WNUrLkgeoAldba7GVwVjmDKxcM37r2/ZjKh
	 odSfHNGEgIw6w==
Date: Sat, 18 Jul 2026 00:19:52 +0800
From: Zorro Lang <zlang@kernel.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: Should we consider disable generic/563 for file systems that do
 not support cgroup2?
Message-ID: <alpUADtQccA2zmWh@zlang-mailbox>
Mail-Followup-To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"slava@dubeyko.com" <slava@dubeyko.com>
References: <ff1c0710cbb31f8ebf51457c0629a496ea6f658e.camel@ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff1c0710cbb31f8ebf51457c0629a496ea6f658e.camel@ibm.com>

On Fri, Jul 10, 2026 at 07:10:43PM +0000, Viacheslav Dubeyko wrote:
> Hello,
> 
> As far as I can see, the generic/563 test is dedicated to cgroup v2
> functionality. And several file systems fails to execute the test:
> 
> sudo ./check generic/563
> FSTYP         -- hfsplus
> PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.2.0-rc1+ #55 SMP
> PREEMPT_DYNAMIC Fri Jul 10 11:21:38 PDT 2026
> MKFS_OPTIONS  -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> 
> generic/563        - output mismatch (see xfstests-
> dev/results//generic/563.out.bad)
>     --- tests/generic/563.out	2026-04-07 14:19:04.785079940 -0700
>     +++ xfstests-dev/results//generic/563.out.bad	2026-07-10
> 11:33:14.231562955 -0700
>     @@ -4,11 +4,13 @@
>      write is in range
>      write -> read/write
>      read is in range
>     -write is in range
>     +write has value of 0
>     +write is NOT in range 15938355.2 .. 17616076.8
>      read is in range
>     ...
>     (Run 'diff -u xfstests-dev/tests/generic/563.out xfstests-
> dev/results//generic/563.out.bad'  to see the entire diff)
> Ran: generic/563
> Failures: generic/563
> Failed 1 of 1 tests
> 
> sudo ./check generic/563
> FSTYP         -- vfat
> PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.2.0-rc1+ #55 SMP
> PREEMPT_DYNAMIC Fri Jul 10 11:21:38 PDT 2026
> MKFS_OPTIONS  -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> 
> generic/563        - output mismatch (see xfstests-
> dev/results//generic/563.out.bad)
>     --- tests/generic/563.out	2026-04-07 14:19:04.785079940 -0700
>     +++ xfstests-dev/results//generic/563.out.bad	2026-07-10
> 11:36:02.221320239 -0700
>     @@ -1,14 +1,19 @@
>      QA output created by 563
>      read/write
>     -read is in range
>     +read has value of 22014464
>     +read is NOT in range 15938355.2 .. 17616076.8
>      write is in range
>      write -> read/write
>     ...
>     (Run 'diff -u xfstests-dev/tests/generic/563.out xfstests-
> dev/results//generic/563.out.bad'  to see the entire diff)
> Ran: generic/563
> Failures: generic/563
> Failed 1 of 1 tests
> 
> sudo ./check generic/563
> FSTYP         -- nilfs2
> PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.2.0-rc1+ #55 SMP
> PREEMPT_DYNAMIC Fri Jul 10 11:21:38 PDT 2026
> MKFS_OPTIONS  -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> 
> generic/563        - output mismatch (see xfstests-
> dev/results//generic/563.out.bad)
>     --- tests/generic/563.out	2026-04-07 14:19:04.785079940 -0700
>     +++ xfstests-dev/results//generic/563.out.bad	2026-07-10
> 11:37:57.633280743 -0700
>     @@ -1,14 +1,18 @@
>      QA output created by 563
>      read/write
>      read is in range
>     -write is in range
>     +write has value of 0
>     +write is NOT in range 15938355.2 .. 17616076.8
>      write -> read/write
>     ...
>     (Run 'diff -u xfstests-dev/tests/generic/563.out xfstests-
> dev/results//generic/563.out.bad'  to see the entire diff)
> Ran: generic/563
> Failures: generic/563
> Failed 1 of 1 tests
> 
> Should file system (like HFS/HFS+, for example) implement cgroup2 support to
> pass the  generic/563 successfully? Is it generic enough test-case? Should we
> consider disable generic/563 for file systems that do not support cgroup2?

Hi Viacheslav,

I completely understand your frustration. The "generic" test suite in fstests
isn't a universal requirement document, so I can't really answer whether HFS+
should support cgroup2 or not..

File systems that are not supported by fstests good enough, frequently run into
false failures. When facing a test that is "destined" to fail on a specific
$FSTYP, you have below options (maybe more):

1. You can add this specific test (e.g., generic/563) to your daily local test
   exclusion list, refer to the -e or -E options with the ./check script.

2. You can modify the test case to explicitly skip a specific $FSTYP using the
   _exclude_fs helper, along with a short comment explaining why.

3. You can use or implement a _require_ function to check if a specific feature
   is supported, which will gracefully _notrun the test if it's missing. While
   _require_cgroup2() already exists, its granularity is currently too coarse to
   _notrun for HFS. You might want to consider refining it or introducing a new
   helper to help file systems like HFS+ _notrun properly.

I hope my reply help to clear something for you, please let me know if you have
any further questions.

Thanks,
Zorro

> 
> Thanks,
> Slava.
