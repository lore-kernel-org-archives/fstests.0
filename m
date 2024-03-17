Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC3A2A
	for <fstests@vger.kernel.org>; Sun, 17 Mar 2024 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710707905; cv=none; b=rFOoimTuilYZTLl9qeIdKA0zRlOUmPzJWLVPX3m/dGIhB6WuF8+s+/IDpKdxSzfr5B2j3oxsXWrg3Fj/nqrB4qWAbTWjHxAL0YpBTgGqghED2OMzLXODMGJM/Yds55Rws19o6sr9IjAYLB1ajjwqsJbNB/CytmWmkZABj1RcEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710707905; c=relaxed/simple;
	bh=xt9VgBkPcK99+z+hid07/Bt1iBWmOpVPQONcSS4oni8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPEE+tDx1FFMaYhy4mDqfIhMZkmC179zwOP63AcAK9sFI9Hu5ZDzSM6REDv6LS5M0QAlucdDX/cNIT3K7FEuPrNrT8UlsqFTPxim9dGzeC7gyxTmyV3c5QBlRHS7Dd7xXJZvzhmwO+GAh/8VSXkb3yQb7BawCTxmM5fg/4IOs0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4B8EC68C7B; Sun, 17 Mar 2024 21:38:20 +0100 (CET)
Date: Sun, 17 Mar 2024 21:38:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Boris Burkov <boris@bur.io>, "Darrick J. Wong" <djwong@kernel.org>,
	kernel-team@fb.com, fstests@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC] generic/730: ensure EIO after device delete
Message-ID: <20240317203818.GC5975@lst.de>
References: <6165b0018426e58e7427a26eebea3d63e66fed15.1710373423.git.boris@bur.io> <20240315025628.GH6188@frogsfrogsfrogs> <20240315233054.GA3597569@zen.localdomain> <CAL3q7H71Roae5kqc0Hh2=CZxCfLd9Kp7bqAfgo5OcUz==opVow@mail.gmail.com> <20240316144008.GA3615790@zen.localdomain> <CAL3q7H7=szVzNCVdPQnC5T57TV_HXUyYNTirv9Kz_=zZa-jEQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7=szVzNCVdPQnC5T57TV_HXUyYNTirv9Kz_=zZa-jEQQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Mar 16, 2024 at 05:42:30PM +0000, Filipe Manana wrote:
> Mine is also non-debug and yet it always succeeds for me (without your
> patch or any other of course):

Same here.

And the idea behind the test is that when the device is removed the
file system should always return an error, i.e. have a check for shutdown
fs in the read path.

