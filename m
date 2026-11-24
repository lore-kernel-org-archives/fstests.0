Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551039;
	b=U3i3EPwFVWcw8QHkasHhsUwfIw3nkPISBktXRGFXk1TS2o7IEAEY84mRWw9t4N8eLAmJ
	 Ad3P9ygFFtAsUOaG4YNwQfSHLvgXJ8u5QSHgehGOLPFAFeQSWnbZIhAVqZO1EMZPb8HIB
	 MPriX/ICsDybqVyzxSH7PpQzjC+rX780E0s3AXuaTkmSTDBfISs+I76sP0NCglE8n+KxU
	 7MPWkDXSxebFpS68boUafk8C1+qcrFjMsSQZzzO2ewlj91Sv+Kz1PKpRxxkdHVuS3cZsv
	 xMnUXMwYIYtDniR+ATDooCt+X0r/gQ78hf9adiXOCh2AUe3mJwsN0cwPiT9qBjR3SYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551039;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=lZOSMWhPbYNMRPD8VuzkwPd59ueb73pp3UQLpO1IhZ4=;
	b=nfUd/uwmK5Zm3HxqAM+E5sA+HP6gUsBK7mNYbDAhL14oVcyKV9tdnsfyyxfD2xzsjyvd
	 eSRu/wMcrxwf+1Sh/bYJ/oQhaX0CWpMsw6b12w0cPP/XNqLfDDCP6HPu0f59yCOd+5DxY
	 6OQFu0gG1iCeLcVxfqMUMWJVNfWMQ51S7XWQ08RUv5d1at0WAXaXUWWVfhTEW+L/AgC7f
	 by8dggDkHBrs9fRSmBkUgC9QZbtLYCGv4UyZTjHmouZBvvlsRZxV7KNRSvs6YiRYIlXZS
	 a+HJpIpv5ToxAGrgerOc0XrWHKDt7GUdKbhEQn1ZJvtY8f6smebbBZz9mzF+yO4CejQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IWQU2/pv";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD67606A31E
	for <fstests@vger.kernel.org>; Tue, 24 Nov 2026 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IWQU2/pv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3866E1F000CA;
	Tue, 24 Nov 2026 20:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795551039;
	bh=lZOSMWhPbYNMRPD8VuzkwPd59ueb73pp3UQLpO1IhZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IWQU2/pvwkgAtNAKYkM7aC1u2zcETDPTXFpj4oELznPk8UUdQ0LvdE90fl+0/fjNZ
	 HZRSXFYu+pNDGpx/4NJ7C9eHGYbxAOY4w1SBnMe1JvGfnmfZULC1PgSGQ+i40cPPKM
	 pags8psDKFiVRVZrjKRJZZksz7bO5K4G8uE4o2EmiHB7+fjoMKijoEJ4elt2us3I7n
	 a9FowilNZGkIMCUFY2o7dXxfjokaCERs7oDJtticMW4WVtoJ10PJgFHo2cAGKIoIiW
	 uYu4tMUtUdLlIH0oTvd1Yjtkm3Vw1OQvmBm1e8KhesOvy42JfTvpGQIicrc/oDkax5
	 E5EgabesV6GIA==
Date: Wed, 25 Nov 2026 04:10:31 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: cem@kernel.org, fstests@vger.kernel.org, jencce2002@qq.com, 
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] add tmt as a new output format
Message-ID: <awXtyUXGTDbP5KLd@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@redhat.com>, cem@kernel.org, 
	fstests@vger.kernel.org, jencce2002@qq.com, Dave Chinner <david@fromorbit.com>
References: <20261119123910.294544-1-cem@kernel.org>
 <awDMOOZxtQW8A4_v@zlang-mailbox>
 <awWiVSZTul_KdB3H@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awWiVSZTul_KdB3H@aalbersh-thinkpadx1carbongen13.rmtcz.csb>

On Tue, Nov 24, 2026 at 03:51:56PM +0100, Andrey Albershteyn wrote:
> On 2026-11-21 07:19:26, Zorro Lang wrote:
> > On Thu, Nov 19, 2026 at 01:38:55PM +0100, cem@kernel.org wrote:
> > > From: Carlos Maiolino <cmaiolino@redhat.com>
> > > 
> > > I've been trying to expand my testing matrix leveraging the testing-farm
> > > cloud (https://testing-farm.io/), which is a public testing cloud available
> > > for opensource testing.
> > > 
> > > Testing-farm uses tmt (https://github.com/teemtee) to orchestrate the
> > > tests within the provisioned VMs.
> > > tmt however expects each individual test to be, well, an individual
> > > test so by default it would put a whole xfstests run as a single test
> > > case with a looooong report.
> > > However we can use a tmt-report-result tool to report each test ran
> > > individually as a sub-test, so the report looks a bit more granular,
> > > easy to read and prevent my eyes from bleeding while looking at its
> > > testing reports.
> > > 
> > > I know tmt can also be used to orchestrate tests on a local machine.
> > > Although I have no use for that, it might be useful for someone else,
> > > reason why at the end of the run it will also print out the tmt report
> > > file location. This also makes the output consistent to what xunit
> > > format does.
> > > 
> > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > > ---
> > > V2:
> > > 	- Add Murphy's suggestion to the log output if it fails
> > > 	  to add a test result to the final report
> > 
> > Hi Carlos,
> > 
> > Sorry for the late reply. I wanted to wait and see what others thought about
> > this first, though it seems there hasn't been much interest or feedback on
> > it so far :-D
> > 
> > ...
> > 
> > More recently before I was laid off from Red Hat, I had been considering adding
> > a generic hook mechanism to fstests instead, if a user sets an environment
> > variable (e.g., REPORT_TESTCASE_HOOK="/path/to/my-script.sh"), fstests would
> > invoke that script at the end of each testcase with arguments like (sect_name,
> > test_seq, test_status, test_time, report_dir). That way, any CI system or test
> > harness could simply provide its own lightweight hook.sh to reuse this reporting
> > interface, without having to hardcode vendor or framework-specific tools into
> > common/report. Also I thought about adding a streaming format like JSON Lines,
> > where each completed test appends a self-contained, valid JSON record on the fly,
> > ensuring that whatever has been flushed to disk remains intact and parseable even
> > if the system crashes midway through a run.
> 
> Regarding the hooks, I continue to pull this patch by Dave [1]
> into my test machines; it adds generic per-test hooks. I use it
> mostly to run trace-cmd but this could probably be useful for some
> kind of additional processing. I find it pretty useful.
> 
> The original posting didn't get merged, but I can resend it if other are
> interested.
> 
> 1: https://lore.kernel.org/all/20210722064725.3077558-1-david@fromorbit.com/

Hi Andrey,

Thanks a lot for pointing me to this patch! Classic Dave, while the design has
some tricky parts, the overall idea is great. This is actually the exact kind
of external hook mechanism I mentioned earlier, and it's a shame I missed it
at the time.

However, this design doesn't quite fit Carlos's use case. Since it places the
hooks inside `_begin_fstest` and `_cleanup`, it won't be able to capture
golden mismatch results etc.

What I have in mind is introducing two hooks: a `pre-test` hook placed right
before `_run_seq` is called in `check`, and a `post-test` hook inside
`_stash_test_status`. That way, the `post-test` hook can get the test results
and meet Carlos's requirements. *But!* this execution window might be a bit
too wide for `ftrace`.

So I'm thinking maybe we could expose three hooks instead: `pre-test`,
`post-test`, and `post-result`:
- `pre-test`: stays the same (right before `_run_seq`).
- `post-test`: runs right after `_run_seq` finishes.
- `post-result`: runs inside `_stash_test_status` (or slightly later).

This would keep `post-test` isolated from any interference caused by post-run
operations like core dumps, `umount`, `_check_filesystems`, or `_check_dmesg`.

What do you think? This is just an initial thought. I can find some time to
implement it and send out a patch for everyone to review. Feel free to tell
me if anyone has more suggestions :)

Thanks,
Zorro

> 
> -- 
> - Andrey
> 
> 
