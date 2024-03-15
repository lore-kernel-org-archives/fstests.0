Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CAA3BB52
	for <fstests@vger.kernel.org>; Fri, 15 Mar 2024 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517048; cv=none; b=AnqAYJorPbrAgZTldFja78M/5Zw3asD/YyIv0tOFhxKTNnyhpQVSg91mRByXdWBfSR0P+5ngrUnd2qmP4iv1ffA5HX38g4vO21WjYSF/4K5GserwyVCRb94cTXaPHDpfWuQmNcHtnIz/zEU+WUZmEtIs4STW6vu1Q28wmeZtF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517048; c=relaxed/simple;
	bh=FloI9PH5lEFk4UIciyFjfon9QteaO0kiIvi7JNqqTCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODGKHki6L4uMM5fCPbP6Jb1IqZsk569zIEbR1yfs5+QZDviOjOnArkMhvFKTqKN+OYy0tLxKQvWtPm+AMoVLUJi09CpQwBNbEk+kW/mcW3Scn4wPpXrwf9RsRSoN0skTOchKUp3ZZ9Il5tidP3jVg7VO7AYnwspe/hw/j5wfiIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw4QM6+u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw4QM6+u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ABEC433F1;
	Fri, 15 Mar 2024 15:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710517048;
	bh=FloI9PH5lEFk4UIciyFjfon9QteaO0kiIvi7JNqqTCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lw4QM6+uN4m4iS2UBIXtwiKnk+sdLddJLDLIXlbne8mrF4gmhCe4Ccm5E4+bKy4ja
	 PVqtloNGWY9jjrCc3y0n549RzJjkc/Bo9cEtEnFsQtbYeURHlN4FNfR/Z53EXU0kll
	 Rg7AYaONVJh4LmCMpnsO88rk2V/1RzGtyIenK2cmnhJ6JbRzdfE/w1jQmxJ9mckJmj
	 7Yw9sbCR2UVftOF67pVOxSXNDDDDza8JS3hwurZO4kI3OdE61CmSqZsYsVFNrTSbsq
	 RAo0dGV94a0jqRrDHc0jpsoL2TGd2n2PnqRKCF6slAU1SjMAmuxBbwdRwLCqCGMneM
	 QmQKVhhecaoMA==
Date: Fri, 15 Mar 2024 08:37:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Henriques <luis.henriques@linux.dev>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4/006: take into account updates to
 _scratch_fuzz_modify()
Message-ID: <20240315153727.GI6188@frogsfrogsfrogs>
References: <20240314172512.28293-1-luis.henriques@linux.dev>
 <20240314172512.28293-3-luis.henriques@linux.dev>
 <20240315025138.GG6188@frogsfrogsfrogs>
 <87le6j7tbv.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87le6j7tbv.fsf@brahms.olymp>

On Fri, Mar 15, 2024 at 09:11:32AM +0000, Luis Henriques wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Thu, Mar 14, 2024 at 05:25:12PM +0000, Luis Henriques (SUSE) wrote:
> >> Since function _scratch_fuzz_modify() has been updated, its output has
> >> changed.  Modify test ext4/006 to take this change into account.
> >
> > Now that you've blocked off the XFS stuff, what line changed?
> 
> Well, there are three lines that are gone with commit 9bab148bb3c7:
> 
> 	echo "+++ touch ${nr} files"
> 	echo "+++ create files"
> 	echo "+++ remove files"
> 
> And a new one was added:
> 
> 	echo "+++ stressing filesystem"
> 
> However, running fsstress will also add a new line with:
> 
> 	printf("seed = %ld\n", seed);
> 
> So the delta is one line (seven instead of eight).

Ah, ok.  Can you copy-paste that into the commit message so that we have
some record of what caused the need for the adjustment, please?

With that added,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>


--D

> Cheers,
> -- 
> Luís
> 
> >
> > --D
> >
> >> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> >> ---
> >>  tests/ext4/006 | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/tests/ext4/006 b/tests/ext4/006
> >> index 8792167bd9c2..b73692aa5b81 100755
> >> --- a/tests/ext4/006
> >> +++ b/tests/ext4/006
> >> @@ -131,7 +131,7 @@ echo "++ check fs (2)" >> $seqres.full
> >>  _check_scratch_fs >> $seqres.full 2>&1
> >>  
> >>  grep -E -q '(did not fix|makes no progress)' $seqres.full && echo "e2fsck failed" | tee -a $seqres.full
> >> -if [ "$(wc -l < "$ROUND2_LOG")" -ne 8 ]; then
> >> +if [ "$(wc -l < "$ROUND2_LOG")" -ne 7 ]; then
> >>  	echo "e2fsck did not fix everything" | tee -a $seqres.full
> >>  fi
> >>  echo "finished fuzzing" | tee -a "$seqres.full"
> >> 
> 
