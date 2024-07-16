Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF16F41C7F
	for <fstests@vger.kernel.org>; Tue, 16 Jul 2024 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160851; cv=none; b=RYzdjBQ9QUXICpYK/01C84iHrzvvUyNqS4X5FzjOmtaErIiw7XJ5Npe7HOr/K4oS8BNZL0ELTvN8g13MtFYn5r8W9RyUSmlxXYszYJsTuOqEUzIs4+s3fukKUbZ/+CdI1PfzB4s1GWriR6hZGoyz80Ee1PS9LkWjNSsHms91VPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160851; c=relaxed/simple;
	bh=lAmFlwfC/V9Uh3BfhfR0lhhaVzCh7B3O8bClYr94C/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqPK09RgyuU4IaVBTo1m6W+f5cgdRw9NQc5nUl+iCGGaYVHRl8TODP+lojXVm2QWC6S4Dd2sM7hmfzCEqwrMubX5a+MLMSVyVLxUEsSLQgI5j7joM9sHJ3kA2OOORKSqQK/vUSYEqd0712Q/pRwVQ7nlHf4WN9QJjm34ORePgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DmvwV3ZF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DmvwV3ZF"
Received: from cwcc.thunk.org (pool-173-48-102-108.bstnma.fios.verizon.net [173.48.102.108])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46GKDlld027464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 16:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1721160829; bh=DNJCN7wXeP3DhUEOEPQO30cH2wWIlzYuMUz2GsgaLug=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DmvwV3ZFBqJLeYPrnSHYP7bAGe9WUll3ITgLFqac30LMHoRsPz8nfzgf84NWUMj32
	 52G/YoK5QSW0vCtJbJrMkmsKy6mNgnrkjur4xR806OP00RhhXuOVaJuZpn94OF3bdG
	 QQ6KZ8LKm6ZptXwlRRauMLu4oQ7YSfee6dXdJmGnPio1PLFclRwMIg+le8sztUnt87
	 RJjr/ms7KgLMUWM1pLc3ZC95+CYpvXEhRfQ6OzE3E/70m17JlU6nqyg3m5q0l9IvdQ
	 jzqfAuX7IWVsuX7nzAIEKJRnPrAJ7gDmoatu/jhx6gOU9gidKU69Rm/SakwW0xg9f4
	 rkQhLoHvzMqpw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DA7B015C029B; Tue, 16 Jul 2024 16:13:47 -0400 (EDT)
Date: Tue, 16 Jul 2024 16:13:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zorro Lang <zlang@redhat.com>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [ANNOUNCE] fstests: for-next branch updated to v2024.07.14
Message-ID: <20240716201347.GA2166460@mit.edu>
References: <64ec6187145dfd111f22f1ae151ae538@kernel.org>
 <20240715154454.GB70013@mit.edu>
 <20240715195026.5c4qvx2thoeessqu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715195026.5c4qvx2thoeessqu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Tue, Jul 16, 2024 at 03:50:26AM +0800, Zorro Lang wrote:
> 
> Sorry about this trouble to you. Sure, this's a behavioural change, and it's
> been talked several times. Generally, even with this change, fstests only run
> tests/generic and tests/$FSTYP cases by default. So it won't run tests/btrfs
> cases if FSTYP=ext4. But with this change a fs has chance to force to try
> another fs' case by specify the case name particularly (if the tester thinks
> it's good to him).

Yeah, it's not a big deal, and I saw the discusion, and I didn't
realize that it would cause the regression test failure for my test
runner.  It was relatively easy for my to work around it, but I
thought it would be useful mention it in case it would take anyone
else by surprise.

					- Ted
