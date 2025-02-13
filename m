Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964D3201100
	for <fstests@vger.kernel.org>; Thu, 13 Feb 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476290; cv=none; b=jbUsf/JQPbdUi0bkFNQSw9EyMf8mgqcHqIEbSQkya9Lzx7q6hfZ3iXOurCBT/qSZlWhNKFTBL8j3LCr5PRG2Gc5ZD77DJWBYflxKXGAg7EwvTS/zjg/DEGBF+Sk/TYSnRLq15LuSZa6z06HbjHCr99lhU67lbY94ko2UgJ1NB5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476290; c=relaxed/simple;
	bh=07b3aoLXUW1A2UXZ8cLgOjHLydU6nXQVyUgAUcPZXOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n21J9MFA+WPehaxyMXoXRZcbTRHqFXnF/8P87/jeReZVSUJO+VgPc0tVLwZvXjgLCWLaoMjvpWqJfrDG9iQjqGRXIcqQWmxVpSdQDt7QorWR2j0DU43vSUOsqxqvkCjE144N8tm0MPsvWQRPYJMKzuTPCO6ZdtZIiJFBJ+QY5yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxrY4kAh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxrY4kAh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3AAC4CED1;
	Thu, 13 Feb 2025 19:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739476290;
	bh=07b3aoLXUW1A2UXZ8cLgOjHLydU6nXQVyUgAUcPZXOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxrY4kAhF0vP79V5+rivOxuYwRrpH0cQEcipInRrX3DCNShDr4w2LTMTw2+nuHXSh
	 01injyWQFt1abCJaGyvBBUXWv6XzQxMnu21JAOXkmtKTtJg+RUua7GGjTdk0D+opL+
	 J+1Z7JHDAXENfevipFRIKIJLN3ULigvxO/wsMQd0gwIy4JPSAjhrzy4yPYEQqxDKzy
	 z3b+GABUKbRvE7Z7B6sK7y6tYvjkzMoGYwRd/ddhdS9nm4LD/ew2htyvmhFOPVao/V
	 nqiTs9XtnJYjlv9Xpz4mcW/W31/R+ScBNKcCPSkzcfR61NF6vUHSWS97WkFoRduntg
	 SWh6eAfph0kAw==
Date: Thu, 13 Feb 2025 11:51:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] generic: test zero-byte writes to new file
Message-ID: <20250213195129.GZ21799@frogsfrogsfrogs>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>

On Thu, Feb 13, 2025 at 12:06:24PM -0600, Eric Sandeen wrote:
> A bug was recently fixed in exfat where attempting to do a zero-byte
> write would yield -EFAULT; test for that here.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/tests/generic/761 b/tests/generic/761
> new file mode 100755
> index 00000000..e933eb83
> --- /dev/null
> +++ b/tests/generic/761
> @@ -0,0 +1,28 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 761
> +#
> +# test zero-byte writes
> +#
> +# exfat had a regression where a zero-byte write to a file would
> +# yield -EfAULT. Should work on all filesystems - write should
> +# succeed and the zero-byte file should be created.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
> +	"exfat: short-circuit zero-byte writes in exfat_file_write_iter"
> +
> +# Modify as appropriate.
> +_require_test
> +
> +rm -f $TEST_DIR/testfile.$seq
> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"

When does the file not get created?

--D

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/761.out b/tests/generic/761.out
> new file mode 100644
> index 00000000..72ebba4c
> --- /dev/null
> +++ b/tests/generic/761.out
> @@ -0,0 +1,2 @@
> +QA output created by 761
> +Silence is golden
> 
> 
