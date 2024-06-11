Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F391CFA9
	for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 16:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124069; cv=none; b=b2HWAmgFeYGMdVQUPzHRHtO2+sjK00HD+S7rGy39s1lB1ElowL7bcIsZODXDkNWq4Uxn/4OGo1hQb6OZjLIj3E81A7j5vOb5n2LK4fMbXX9Rbabb4UBe7U3Gh0mSNMd1UO0EK8FGaPjyaWGYfQPicTosqH2aFf9wHkDgYT1JT4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124069; c=relaxed/simple;
	bh=uMKlyQCUI6mgN3dAAjbXUow6YAasXn+xBjE81ZXmDKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck5VmPG2Z/bouxuvUpUtdvgkqlhTquXZZKLXrvNH49/dyki7jDaxsYJVyaSw0r0Tck3sqz4mKKHyWjnw1LPHCG3t5U6Dnfu7/g+Wb1IinB9mhc/bsWmNRlGMxUenKwkD+G7IZ7QKPO0p8DLjKMTJ3J27e/ihc6j0hkEZN+oKyb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dnvXPMdf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dnvXPMdf"
Received: from macsyma.thunk.org ([84.247.119.26])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45BGepar014643
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 12:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1718124053; bh=CqJMSmn7i8fymmD5JidzQkMppDaBku7ESVvfrHQ2k9c=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dnvXPMdfhCxSJmgehKEeRGuaVNlh+Sg9gQLRZkuc1AGp5T85Fw4/m884Fc1LULZxZ
	 pt9F1/k0jVPagc8oYPiXycFXY6F9N3w/zKwM6VVDIXLl4qnwWuYwfDOjpi2nuYYHv8
	 JRIDk7UlhQtd8GG0638Ya1CqS/Qxrx+f4JTdhGbK7YvIHLkonmyyLhV2otrWkSpqwt
	 +NILRt7E3CokeoIz/o0RdboQ3LLaiXLZUBmpAQvXpP/0DyYBy2oMny6Udvi15+R5vM
	 G09BPFeiDS8NTAsKg3CKB1MAXGI0FFKgmtlW3t2BQOSehsKqhK3qgSq8R9NHrgKiCO
	 IJmn9bobIAYsw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 2066B341669; Tue, 11 Jun 2024 18:40:49 +0200 (CEST)
Date: Tue, 11 Jun 2024 17:40:49 +0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4/045: skip test if the block size is 1k
Message-ID: <20240611164049.GG4182@mit.edu>
References: <20240611085853.200102-1-tytso@mit.edu>
 <20240611142754.GF52977@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611142754.GF52977@frogsfrogsfrogs>

On Tue, Jun 11, 2024 at 07:27:54AM -0700, Darrick J. Wong wrote:
> On Tue, Jun 11, 2024 at 04:58:52AM -0400, Theodore Ts'o wrote:
> > If the file system is 1k, this test will fail because with dir_index
> > enabled, the directory tree will get too deep, and the kernel will
> > return ENOSPC and log the EXT4-fs warning "Directory (ino: NNN) index
> > full, reach max htree level: 2".  So if the blocksize is less than 2k,
> > _notrun this test.
> 
> Didn't ext4 recently gain support for 3-level htrees?

Ext4 has support for a while, but it's an optional feature which is
not enabled by default.  I suppose we could try to set the feature,
and skip the test if the kernel doesn't support it.  (Or decide that
no one cares about RHEL7, and just YOLO, since who else still cares
about kernels older than 4.13?  :-)

I'm just not sure whether it's worth the extra complexity to do it,
but for those people who care about code coverage statistics, it would
help a tiny amount....

						- Ted
