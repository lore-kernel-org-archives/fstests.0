Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29E42AB7
	for <fstests@vger.kernel.org>; Wed,  3 Dec 2025 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764728319; cv=none; b=FiPzfbPMg6Gw7R1B6ohOUyQXdM0p2NReN/hU4uFxUPCiwZHk43oG22ElDnroYnU/fUOsn+0VOnfiLvqHvtFc+95TNy7NOkLK0qW0cQrBllmb5V1kq5niy6kBFfPBYpy+Ri1Kkyiucnh0ummMsOJcPK2RxIPV/a0+3S14w/F73dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764728319; c=relaxed/simple;
	bh=3NWHU9OroYLHQK9aNlXIME2y4mcvZDKdDtqZqwBX55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp4LPkCr2KbJNKKSoGzpnOVnVhSYzltkoyIEh4wcIMICvtYIDm+dct8KtfXV8jutMsbSE5hyILIoS7yMMsK+KCHS9O+nXCa+2iNZGe7+JxSFeUNjk0q5SsjqZKb9RAOMMP7PgHyxVppbwB3JAl3EuyqSlucFoFpUkMe98yZsCkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Eti7T6Qk; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Eti7T6Qk"
Received: from macsyma.thunk.org (pool-173-48-102-12.bstnma.fios.verizon.net [173.48.102.12])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B32I9N4002251
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Dec 2025 21:18:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764728291; bh=OA5BPPFPWdY1GGA+qoGP4dlLrTO9cnCg3u+3vMgwFRc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Eti7T6Qk1jdPBi8XpZLNi7KBPC8jLhcgPL7SUMH4826Pgw2qlj17gyb1HelDJHUvm
	 Spx347nVL2ud3eCKU6QXGsnvkVnkFhj5YZbKIAxSJdJ9lX12gjgrY85+xJcMxZiA/G
	 SSw33AISQZ0xn4QoM5F+k6aAqaQOwVWSbI2LErknV1iZHPnkrgecAHnEpUZdfqAcnB
	 9rX8trbgEBMaVPiKmGEqLKwpXiA+HcW7oaXOWZ3YNgnMXWcbKRaGKkrxUEoCE4DSxm
	 Ni2+VFdZnuG6Hu5sQa/XZRRyp9EEJCUigTeJ2JlcsieHWX+/w07DB2DEQzeAeVHauo
	 bvsJtvon/TFHQ==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 75E604DF2C06; Tue,  2 Dec 2025 21:17:09 -0500 (EST)
Date: Tue, 2 Dec 2025 21:17:09 -0500
From: "Theodore Tso" <tytso@mit.edu>
To: Jaegeuk Kim <jaegeuk.kim@gmail.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org
Subject: Re: generic/204 is crashing on linux-next when testing f2fs
Message-ID: <20251203021709.GA71988@macsyma.lan>
References: <20251202043952.GA70808@macsyma.lan>
 <CAOtxgyeik6kgF6SktvFj=anntmJZ_aWneqq1XzLpqpHK1XMb+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtxgyeik6kgF6SktvFj=anntmJZ_aWneqq1XzLpqpHK1XMb+Q@mail.gmail.com>

On Tue, Dec 02, 2025 at 09:30:44AM -0800, Jaegeuk Kim wrote:
> > For now, I'll exclude generic/204 from the f2fs configs in my test
> > appliance; if you have a chance to take a look at this and let me know
> > when it might be safe to re-neable generic/204 for f2fs, that would be
> > great.  Thanks!
> 
> Thank you for sharing the report. I didn't hit this in my setup tho, let
> us try to reproduce it first.

I'm not able to reproduce it by running generic/204 by itself; only
when running the full auto group.  (See below).  The generic/204 test
reformats the scratch partition at the beginning of the test, and
doesn't depend on the test partition.  Presumably, a previous test
when running the auto group is somehow setting up generic/204 to fail.

I'll try doing a run with KASAN enabled, in case that gives us some
insight.

						- Ted
							
TESTRUNID: ltm-20251202161646
KERNEL:    kernel	6.18.0-rc4-xfstests-kasan-00072-g6fb67ac89690 #314 SMP PREEMPT_DYNAMIC Tue Dec  2 16:05:26 EST 2025 x86_64
CMDLINE:   --kernel gs://gce-xfstests/kernel.deb -c f2fs/all -a -C 30 generic/204
CPUS:      2
MEM:       7680

f2fs/default: 30 tests, 6043 seconds
f2fs/encrypt: 30 tests, 6209 seconds
f2fs/compress: 30 tests, 6140 seconds
Totals: 90 tests, 0 skipped, 0 failures, 0 errors, 18392s

FSTESTIMG: gce-xfstests/xfstests-amd64-202512020012
FSTESTPRJ: gce-xfstests
FSTESTVER: blktests	4badb27 (Fri, 31 Oct 2025 19:53:27 +0900)
FSTESTVER: fio		fio-3.41 (Fri, 5 Sep 2025 14:21:17 -0600)
FSTESTVER: fsverity	v1.7 (Tue, 4 Nov 2025 17:28:17 -0800)
FSTESTVER: ima-evm-utils	v1.5 (Mon, 6 Mar 2023 07:40:07 -0500)
FSTESTVER: libaio  	libaio-0.3.108-82-gb8eadc9 (Thu, 2 Jun 2022 13:33:11 +0200)
FSTESTVER: ltp		20250930 (Tue, 30 Sep 2025 13:53:45 +0200)
FSTESTVER: quota		v4.05-77-g22ff3d9 (Tue, 2 Sep 2025 08:12:02 -0400)
FSTESTVER: util-linux	v2.41.2 (Mon, 22 Sep 2025 12:56:34 +0200)
FSTESTVER: xfsprogs	v6.17.0 (Mon, 20 Oct 2025 16:49:00 +0200)
FSTESTVER: xfstests-bld	gce-xfstests-202504292206-34-g84a091b7 (Tue, 2 Dec 2025 00:09:25 -0500)
FSTESTVER: xfstests	v2025.11.04-12-g64e3dbda7 (Thu, 13 Nov 2025 19:58:03 -0500)
FSTESTVER: zz_build-distro	trixie
FSTESTSET: generic/204
FSTESTOPT: count 30 fail_loop_count 0
