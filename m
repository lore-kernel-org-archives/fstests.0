Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595630326
	for <fstests@vger.kernel.org>; Wed,  8 Nov 2023 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZBsc2cZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDFEC433C8;
	Wed,  8 Nov 2023 21:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699479896;
	bh=bwAkQ1keow733iSzPUVTKad5IQrPCN6u6+ISNqDQ6a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZBsc2cZil9EGk/Wb2ZSE9qJNaerHnC2Bp+GeFuLWuHqfR60ddFW2I/O3TmsykDwY
	 VD3kja2cFTLk+xIgc2fAtPpeeqxb6KaH1RHF4FSLX2/PmBshnBQy9ZIizdVpXGqkVM
	 xnMhxDC+qZ2xuaKv0B51mvK/rHMEzXLJURxSRkDPM0S1tfb0KmpDOtJNwDvSo80SjL
	 QoeeQ4u50fIn61bz31QyCIofz0OCj6EQPs0X8jPNXX6VWbbyeBkivURAoR4VSAFRco
	 szP7a8iubWmZw+rRZNmFNzA+WZRYWy/vQtvjF25yDEpCnY0IdW7u8iFFR38CKmyzpm
	 nXIgNZgE3PtOg==
Date: Wed, 8 Nov 2023 13:44:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] common: fix _require_xfs_io_command for specific swapext
 versions
Message-ID: <20231108214456.GD1203404@frogsfrogsfrogs>
References: <20231108152401.432980-1-hch@lst.de>
 <20231108213334.GC1203404@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108213334.GC1203404@frogsfrogsfrogs>

On Wed, Nov 08, 2023 at 01:33:34PM -0800, Darrick J. Wong wrote:
> On Wed, Nov 08, 2023 at 04:24:01PM +0100, Christoph Hellwig wrote:
> > The xfs_io command (only in Darricks trees and not upstream yet)
> > supports the -v switch to select the swapext version.  When the selected
> > swapext version is not supported it reports a 'version must be $foo'
> > message.  Parse that and don't _notfun the test cases.
> 
> Er... which _require_xfs_io_command call fails?  The only patch that
> adds 'version must' adds both '-v swapext' and '-v exchrange', and
> AFAICT all tests use one or the other if they specify a -v at all.

DOH.  I forgot that the command line switches all got renamed when I
withdrew FIEXCHANGE from consideration as a VFS concept and turned it
back into a private XFS ioctl.

I'm about to email the conversion series for fstests that absorbs that
change.   Would you mind taking a look to see if that solves your
problems?

--D

> --D
> 
> > This fixes various generic tests trying to use the vfs version that
> > doesn't exist in most branches implementing the swapext command.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  common/rc | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 26a26085..d8a0b19b 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2706,6 +2706,8 @@ _require_xfs_io_command()
> >  			_notrun "xfs_io $command $param ioctl support is missing"
> >  		echo $testio | grep -q "Operation not supported" && \
> >  			_notrun "xfs_io $command $param kernel support is missing"
> > +		echo $testio | grep -q "version must" && \
> > +			_notrun "xfs_io $command $param kernel support is missing"
> >  		rm -f $testfile.1
> >  		param_checked="$param"
> >  		;;
> > -- 
> > 2.39.2
> > 
> > 
> 
