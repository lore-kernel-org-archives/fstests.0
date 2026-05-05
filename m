Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB12F31F999
	for <fstests@vger.kernel.org>; Tue,  5 May 2026 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988057; cv=none; b=CixwfiqAjXu4PYJLvUb8vKh/BtDcA+H5Xmx3WyFzlo5ikZCzhPxdwMl5cH4bv5DUBBsB9tQy/L/kRR54pIylApRzzmmXyxhxUtQzyTcEF0wO6+BWkO9jJU3CFT5/ZZjO01gei3xRvcJVuUzqfl1KLEBaEhUAY93w6dclFGPMTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988057; c=relaxed/simple;
	bh=NM1SCLtqlQ/NwM4h+hTZLgCXW+cKnT22vxDEaqcpSy8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdeNZSheEn/Y2zh1FO8RjyLDx4viSm7WsAqJ+8wFFZIDGS9DXS8OtCFx+43rGeHn3FNadnP7fu0pZWxCUA2YM6izNSvD9kf1p3WL3HxG1llfyL/K4RbzxqhYpT4A2SXixy6VmyJF2oQFIBE3a4O/cjwGGLxoee2hQKrl0pomquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=n56k1bwy; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="n56k1bwy"
Received: from macsyma.thunk.org (nomadix.esplanade.hr [213.147.98.98] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 645DY92Q006878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 May 2026 09:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1777988052; bh=XWN+HA9anPem0nYWIMF1NYxFVByoRFHQBsWX1twfmR8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=n56k1bwyZ/A+zGBd/S3ZUzMGY7HbkkYkLrkkOz6FniPhxddpjVGkwD0ucy50bpfiw
	 uKQKjZdnlfMXHGQc3y0huDzeHg9Pv2/wGNQ0wLywcAQ6MLWfEy9SsGSBAlPtWbHCBb
	 DlVB5T4ddb+UXosBtsXgcY8ueduFkcOSRodcVMpSZ7U5Xmcmwg4fKhmZs0I6TB6Lto
	 7Q7ENhhdTA3HAEYMd4D/zZgHYaSad9PsfBMqQQGJjnuYteD4wNR/TSSzoxcNh8S1cJ
	 vhLCspdCQB0rUkxZmHHo7jlTPe39Bcbg8JbMPIq3u3IrKoSsQuWdVUosew/O/iogED
	 8Sf7Cbyjk0V4Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 25F906647872; Tue,  5 May 2026 15:34:09 +0200 (CEST)
Date: Tue, 5 May 2026 15:34:09 +0200
From: "Theodore Tso" <tytso@mit.edu>
To: fstests@vger.kernel.org
Subject: Re: [PATCH RFC] check: add new option "--loop <n>" which runs each
 test multiple times
Message-ID: <20260505133409.GA49070@macsyma.local>
References: <20260415213248.1795275-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415213248.1795275-1-tytso@mit.edu>

On Wed, Apr 15, 2026 at 05:32:48PM -0400, Theodore Ts'o wrote:
> Teach the check script a new option --loop, which re-run each test
> multiple times.  This works very similarly to to -L, which will retry
> a particular test after it first fails, except that the test is rerun
> unconditionally.

Ping?  Does anyone have a preference between adding a new option,
--loop, or changing the heaviour of the -i option?

> This differs from the "-i <n>" option, which iterates each set of
> tests <n> times instead of each test.  The -i option is problematic in
> two ways.  First, it doesn't save the test artifacts from each test run.
> This is unfortunate because when the developer is trying to debug a
> flaky test failure, running "check -i 100" will run a test 100 times,
> but if only the 42nd test fails, the NNN.out.bad file for that failing
> test run is not preserved.  The second difference between --loop and
> -i is the result.xml file is rewritten after each test set, so we do
> not have the cumulative statistics of the 100 test runs in the junit
> XML file.

						- Ted
