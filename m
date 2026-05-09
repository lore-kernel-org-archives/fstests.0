Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429D78F2B
	for <fstests@vger.kernel.org>; Sat,  9 May 2026 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778348836; cv=none; b=YR5ZnHnIuDtQdpbUpaxlPkbOweqIfO0dxtEe9FxQb6n0QS2uLpOwgW1RgU8SNedj9MMrQyJuSQC+QCjUmZCyWPPEcSNUf6/jJsV0icC/OvCCZ6VRagKYmOcvYfW7Rf5Z+uCQPCtXzFrxkEYJ1iVMgrSPtdbaWH3XAeHl4lMccKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778348836; c=relaxed/simple;
	bh=9oMu5y7LgAUgg4CsQqOkQlH9XSECaP+8eP2hTaWCDgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs8BtcJn4BuokiowIT5fTaveZxfOt0Gao3l0ZiIkXONaB2CGKFFezb3L8HkcL8E4JVcNrtBpaNxZVfVp1GvnNEKLTpVwMNHlyOXfMn19x634UPpFBH0+gu7Ct/ltqmYoKUb58i0OjVJL5ZBB1AeKZ4rWTkDCYhl92VU+ihGilXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WY30O7gE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WY30O7gE"
Received: from macsyma.thunk.org (pool-173-48-82-102.bstnma.fios.verizon.net [173.48.82.102])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 649HhhR8017346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 9 May 2026 13:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1778348625; bh=u95pvMZH+VFMgNdJY3tmEquHHcBl4IXGvnFM/7H+0BY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=WY30O7gE2327UP5NoTstS6HCk2SJ/dZx1vcNLSUv4CEIRpD1QLWki6DzRp00MBdsl
	 h694csPSW/GIETZJI0UMlOjzeuGQR2/qUIGUy2rke0ilykcCMzRJklsJQygUAWC3Pn
	 rdpRTOlhHyPdNxC2k5jkqO2HQw4WrZ2v6ErHlsDynbgiMe1+F+Qt+1iWaerFLX4n7p
	 UNddGBWjBcPJwppbFV+WtAOQMa/MdK5EjFa0GPsLnsoAdNH4mRv3hiS6dW1FULV45h
	 hFIhvsgSgQkNK89IV5EJZPkO+7yQRSWx6i3Q+UXbS8QA0nWoaZIQ0IflAUcsGGiniu
	 t9Hta4VXxyTww==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id EED2766BF10F; Sat,  9 May 2026 13:42:42 -0400 (EDT)
Date: Sat, 9 May 2026 13:42:42 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc: fstests@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [PATCH 2/2] ext4/065 encryption + casefold + dirdata feature
 combination
Message-ID: <20260509174242.GA51497@macsyma-wired.lan>
References: <20260419185209.4526-1-ablagodarenko@ddn.com>
 <20260419185209.4526-2-ablagodarenko@ddn.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419185209.4526-2-ablagodarenko@ddn.com>

On Sun, Apr 19, 2026 at 02:52:09PM -0400, Artem Blagodarenko wrote:
> From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
> 
> Test ext4 encryption + casefold + dirdata feature combination.
> This test verifies that files created in directories with encryption,
> case-insensitive (casefold), and dirdata attributes work correctly.
> See ext4/064 for the same test WITHOUT dirdata feature.
> 
> Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>

Note that the dirdata feature patches have not landed, and I've
expressed concerns of this patch set[1].

[1] https://lore.kernel.org/all/20260418214359.GA58909@macsyma-wired.lan/

From manual code inspection, the dirdata patch was never changing how
the data was stored.  So before we land the xfstests changes, could
you please add support in debugfs to set and get the dirdata stored
for a directory entry, and then change the test to actually _validate_
that when enabling encryption + casefold + dirdata, that the encrypted
hash is stored as a dirdata attribute?

Thanks,

					- Ted
