Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C382B3CF6E
	for <fstests@vger.kernel.org>; Tue, 19 Mar 2024 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882651; cv=none; b=H3ojWyDcaK/9o8ka1g6vpeAqF+UnrI2ZQGjbQ4XryCpRmM8/pbrs9dDdQQz1F3tGdo4ptvlm3EjLvgrcnqI92Bz4WI2nhragAtxY/Zx4LyNna/Fg8IbbDgqtt5p09AKrAJYc847p85+oBWWiBAW5Bk2VbQRoQpkfyumTZWPGOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882651; c=relaxed/simple;
	bh=N40dZXu3NjaGgTHwDvcz3SLHGNpkS1I7P9yOohaHB6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h23OK0mGyEPEso+RpenLJwr+q/BvaNT+NfpZ9X0wLDC1vAltods+V7U/70/rP9BYjg2/w7PyqYQ2U5KBCwDLZ4dUdQXCAgY6/k212IAXZFZkBX5niY474Y90RGp2PeII9be8mNpOq6EvvQcZRmRXHC3w4bDCkesUyblxIwZdUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTF1kbWC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTF1kbWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F71CC433C7;
	Tue, 19 Mar 2024 21:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710882651;
	bh=N40dZXu3NjaGgTHwDvcz3SLHGNpkS1I7P9yOohaHB6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTF1kbWCavnurtCjvaikczbAaeBsdvyqxDVuIydy+QXSuxWmQbghb5VhJMnysFuoa
	 qltuaWDwE3aqDFmwiU1KBpF4fEoeZ89gUA5ggQvfJgjdrYUiPgBkGmFHR+xLEXHf9M
	 mg4YrQi9KrXio/1+VRzOt+NruFcZ5+fjx34FpSt2dxuW5cBk/0ePQlNS4rKybIynxh
	 mAcyatSxKimP1U69iwf3UL6V247yghyVleDWVXFhr9Ta+vyfJBboITzPP7zZv51bDS
	 niE745k8zfpfrvE+vt9vxjiOhHvYaTG4wjEOVxZYgRtpWkSCvizkyFkYxrLQ1uUPAq
	 rFfnL6wUqsmaQ==
Date: Tue, 19 Mar 2024 14:10:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>, fstests@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 5/5] generic/733: disable for btrfs
Message-ID: <20240319211050.GL6188@frogsfrogsfrogs>
References: <cover.1710871719.git.dsterba@suse.com>
 <094a1bdc304b236ba41aff4da454abe3c93a355c.1710871719.git.dsterba@suse.com>
 <Zfn9DMR8UQQMiyiL@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfn9DMR8UQQMiyiL@infradead.org>

On Tue, Mar 19, 2024 at 02:01:00PM -0700, Christoph Hellwig wrote:
> On Tue, Mar 19, 2024 at 07:12:10PM +0100, David Sterba wrote:
> > This tests if a clone source can be read but in btrfs there's an
> > exclusive lock and the test always fails. The functionality might be
> > implemented in btrfs in the future but for now disable the test.
> 
> Well, this sounds like btrf sis broken and it should fail?
> 
> >  # real QA test starts here
> > -_supported_fs generic
> > +_supported_fs ^btrfs
> 
> 
> and just throwing random not supported in generic testes is just a mine
> field.  You;d better explain very well why something is not supported,
> and do that by adding a _require_.  If you can't explain the
> _require this probably actually is a bug and not just an exclude..

I don't think there's a good way to _require-test for holding i_rwsem in
exclusive or shared mode during an FICLONE operation.  But that ought to
be a comment somewhere at least.

--D
