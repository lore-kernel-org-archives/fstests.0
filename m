Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D6266565
	for <fstests@vger.kernel.org>; Sun, 19 Jul 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784469846; cv=none; b=EuJKK2nVYWwMf3J7VQkIjh6MAR4tfrkLCGOgLSfV39Rd9LQ1ygSW1W9ytbMbZzP7/pDt7b/Hp1e58I505LstzNxHc1riCOl8tghgR9C+868XPU33mZXxFza/+dsoTDD1PGwEgvzYSAoAqW9xqxv5ABmX3DJbD04IZRp9S0tlFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784469846; c=relaxed/simple;
	bh=osyROd93POfyOOAZk4u5xr6vi8R3kY/gxQkaNFM3o1Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+1rRAsysO6VE70xrOamjxthmemoN3izfdhhs0Amb5hdKBvx3MuJiE1RfS58ciEz/R3wvlA9ispbw7XX+6ftwnK3Dbgr3iGMbFlc7vN7X7GscrMSFRWjIfh/dagqy/TAS8OAh9ldzCf02oGjoA/z1S7650MDkjNs4o7lVGxJV/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pED9gOSP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pED9gOSP"
Received: from macsyma.thunk.org (pool-108-49-65-18.bstnma.fios.verizon.net [108.49.65.18])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 66JE3lWQ014013
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 10:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1784469831; bh=5olBAkXzioxEkCEOsftyBbRRLWd9ApMth+0d0VfGEHw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pED9gOSP1QKoQVD6ADUgX/OCS5TnuUDrWwaLzmUiHH7FXcSVE9lydv2ROq4LJMk5n
	 qBLxIUWhTBY8aAUtNYyq7E9T5t+Glsejwt60+TQ0VFeFw1/anPyFu7INY5hHA73TC9
	 VK1ZD4Swn+ISkNYKlIlhHqcPlxSpRw59tI7uVz05KeVzmo4C2U/ZiYFfz1wkcPwU3E
	 I3fHinWAfWJiAZPTlu6BceqWyD4BrkSXpip1Qxt79Mxh/ZMVAZQOtRW3iKgdDnKi7K
	 KYlp12ff6DOtvVwc0BpCZtW9AF+J/GpfcqlD+cRYoWEMjRYThmjXxy2OKusDFSAoYH
	 kMJ2Kt+X9tAfg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 6F012ACB2F4; Sun, 19 Jul 2026 10:02:47 -0400 (EDT)
Date: Sun, 19 Jul 2026 10:02:47 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Subject: Re: Should we consider disable generic/563 for file systems that do
 not support cgroup2?
Message-ID: <alzYSGVz86d7wDXn@mit.edu>
References: <ff1c0710cbb31f8ebf51457c0629a496ea6f658e.camel@ibm.com>
 <alpUADtQccA2zmWh@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpUADtQccA2zmWh@zlang-mailbox>

On Sat, Jul 18, 2026 at 12:19:52AM -0500, Zorro Lang wrote:
> 
> 3. You can use or implement a _require_ function to check if a specific feature
>    is supported, which will gracefully _notrun the test if it's missing. While
>    _require_cgroup2() already exists, its granularity is currently too coarse to
>    _notrun for HFS. You might want to consider refining it or introducing a new
>    helper to help file systems like HFS+ _notrun properly.

It may be rather challenging to determine whether the file system is
supposed to support cgroupv2, unless we want to define a VFS specific
flag and a way to query it via sysfs.  If we want to encourage the use
of the simpler file systems to use xfstests, we may want to consider
that approach.

						- Ted
