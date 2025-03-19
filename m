Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCE290F
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 23:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742427180; cv=none; b=DEptqKgk/xm55m3KXhSe9C6pexONHuUQB/04gG2bFpDXQmSlVpVUr5U5u9K3+A5Jk1w+VvMHdcb00FMmbGG31v5Ig/hz161iNNDDyeX+u2CXZG8y9F5Cjmam58FzESyrT5QYtnGaEV4FN7s33PtViFkQRixJZ5/LcNsGC6fPXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742427180; c=relaxed/simple;
	bh=MB1JMNzD4XRW0LlQd6U37BSrR97Zokqy2t80dgdhhhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaaiVbrPxkh8TQeTE6WfcutFYo4/4Fs4K5PnTJ+rpfeMy9T1M6SdkFoFmk0T84IKXaQqcZ5vFgU2Hi3FlWByKfMQ8M755WJiDFMgXOmHY/HY1/kTj8VzTYUe4bFC8J373ATxauc5YCB8a1rYglXp+iO2sgHlixhzYiOuT9lH39U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-222.bstnma.fios.verizon.net [173.48.82.222])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52JNWhTo016090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 19:32:43 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 015292E010B; Wed, 19 Mar 2025 19:32:42 -0400 (EDT)
Date: Wed, 19 Mar 2025 19:32:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zorro Lang <zlang@redhat.com>
Cc: Eric Sandeen <sandeen@sandeen.net>, Christian Brauner <brauner@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
Message-ID: <20250319233242.GC1079074@mit.edu>
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
 <20250318235116.GE787758@mit.edu>
 <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
 <20250319151144.3r27tjgenbzty5tr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319153902.vn3xcttrrytrkfx3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319164410.GB1061595@mit.edu>
 <20250319200142.dmt2sz2jnotmyjeo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319200142.dmt2sz2jnotmyjeo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Thu, Mar 20, 2025 at 04:01:42AM +0800, Zorro Lang wrote:
> Fstests supports overlayfs testing with different underlying fs, for example
> if you want to test overlay with ext4, you can set local.config as:
> 
>  FSTYP=ext4
>  TEST_DEV=/dev/sdb
>  TEST_DIR=/mnt/test
>  SCRATCH_DEV=/dev/sdc
>  SCRATCH_MNT=/mnt/scratch

Yes, I know.   My test appliances has autmation around setting local.config

> 
> then does:
> # mkfs.ext4 -F $TEST_DEV
> # mkfs.ext4 -F $SCRACH_DEV
> # mkdir /mnt/test
> # mkdir /mnt/scratch
> # ./check -overlay -g auto
> 
> For more details you can refer to xfstests/README.overlay.
> 
> Currently fstests only supports overlayfs testing as this, other fs, e.g. nfs,
> has to prepare nfs SCRATCH_DEV and TEST_DEV by the user. I'm thinking about
> supporting other upper fs testing likes overlay (if it's helpful).

I have automation that handles this, so I'm good:

./kvm-xfstests --primary-fstype xfs -c overlay/default -g auto

My point was that might be the reason why it might be convenient for
the test generic/699 being in generic/ instead of overlay/, since it
means that people who are runing a large number of configs, e.g.:

./kvm-xfstests -c ext4/default,xfs/default,btrfs/default generic/699

can easily test overlayfs with idmapping with different underlying
file systems.  (Note: this is where my automation will write to
local.config while iterating across different file system configs).

Is it worth regularly running generic/699 across multiple underyling
file systmes?  I dunno; I'll let other people chime in on it, since I
don't really use overayfs with idmapping myself, and I haven't
examined the code paths in question myself.

Cheers,

					- Ted
