Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6149AA54
	for <fstests@vger.kernel.org>; Thu, 10 Sep 2026 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048257; cv=none; b=ZrqherhxvVoQEduhrQxOkW/Lld+zpUVeVzi2Bs7pgR6ViAj4sXyTKigxSucKC67zzPsGAQOs+rvkisYFdOlpRZh1+axzvVQa8CB1eaodN1SIKX4hB3JZmLIxNaKj++Im4tqdBdyczaN+RAvv6kjiKUsRuJtCkuhjN2tZXrFoC5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048257; c=relaxed/simple;
	bh=/GgnJUSlkpKOpbFArjbVLuedEGJXAGizkH1VsKyTFZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtS8fVVHTlsyLk47lNR3l4r30HPU6uNgvO6XMDt4FNckLCAVRUKwz0sDgwgw0mCP0pKXm51R3iiPoPH293ZDkKohwktEhPOAQ8lVvVfHf4EHgKZ1Q5h1vrQBFiIcGkupu7l5kU1PuFNCuxeOMTqojF59zJU8aB7TASYTPEY24g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OPpK6kAI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OPpK6kAI"
Received: from macsyma.thunk.org (pool-108-26-156-127.bstnma.fios.verizon.net [108.26.156.127])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 68ADoTYp021751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1789048232; bh=JdSOWjSlp3lgQ5ds/SlNQC4dC1szhw6bc5gPQeD5iVg=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=OPpK6kAIC6mh7TQHoaM22w9iw7UHnXVuaXH1Sxfzfg8lYMngwrfGtyr+8QT/FFGq1
	 f29AnFXsrH/Rkw68auP9OrWxhxH2XuULQZgUDZKty2SH6zN8zzD3ECOBR5/0XrNaxN
	 nXNnHgpKA3buVuT/KYmCF3g3etn5kiaByh5WMPwbxXubCgD9UHODohq1nyvNqcHc//
	 a52AUoOlxL9eXE0/qO3fruW/LUINLBG5z+BXd2I4AK9n9VOvLPChcdoCPJYTusYNPV
	 HxHr3O5odT/Zlwi8RBI0vMAcEe00shdvQn9HwwS0somgudbFFguHBrjklI+ovxVmKM
	 h8Dan6l7+pAiw==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id BC149144D640; Thu, 10 Sep 2026 09:49:28 -0400 (EDT)
Date: Thu, 10 Sep 2026 09:49:28 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, zlang@redhat.com,
        fstests@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        vdubeyko@coreweave.com, linux-fsdevel@vger.kernel.org,
        frank.li@vivo.com
Subject: Re: [PATCH] xfstests: exclude hfs/hfsplus from generic/339 run
Message-ID: <aqKzDpccJgkmzC5E@mit.edu>
References: <20260910000449.747189-2-slava@dubeyko.com>
 <aqJ--AqubS-CWiV-@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqJ--AqubS-CWiV-@infradead.org>

On Thu, Sep 10, 2026 at 02:57:12AM -0500, Christoph Hellwig wrote:
> On Wed, Sep 09, 2026 at 05:04:50PM -0700, Viacheslav Dubeyko wrote:
> > The dirhash_collide generates filenames from arbitrary random
> > bytes (only '.' and '/' are filtered out), which are not valid
> > UTF-8 in general. Catalog names on both classic HFS and HFS+ are
> > Unicode. Feeding random bytes causes fsck to report "Illegal name"
> > or catalog corruption that has nothing to do with directory
> > hash-collision handling, which is what this test is actually meant
> > to exercise.

I'm curious --- does HFS/HFS+ reject unofficial Unicode characters
such as those used by Klingon?  (Klingon is an invented/artificial
language, so it's considered out of scope by Unicode; so Star Trek
enthusiasts are camping on an unofficial block of the Unicode code
set.)

Invalid Unicode characters could also happen because newer versions
of Unicode have added new emoji's, which might be added as support in
the mobile handset userspace, but since we aren't regularly updating
the Unicode tables, they might still be considered invalid if you
enable strict mode in ext4/f2fs.

> If user file name creation manage to trigger fsck complaints, you need
> to righten the input checks in the file systems first to fix this.
> 
> We can then find a programmatic way to deal with these rejects in
> xfstests, as ext4/f2fs in case insensiive mode probably have the same
> issue.

Well, strict mode isn't enabled by default, since users might want to
use Klingon or emoji's with a skin color that matches their own.  And
no one has been invested enough to continuously update our Unicode
tables, and add support in the userspace tooling for upgrading the
Unicode version in the file system superblock (which would then break
compatibility with older kernels --- for example, if they downgrade to
an older version of Android, etc.)

Isn't Unicode **fun**?  :-)

    	       	       	      	   	      - Ted
