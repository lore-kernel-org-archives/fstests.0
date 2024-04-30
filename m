Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F417164E
	for <fstests@vger.kernel.org>; Tue, 30 Apr 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481803; cv=none; b=pBdfyVe7fcYTz3ZxBtwRr4GXxVhKv8WLufmo69LmZli5U6mqGidqwZI4eqb2Uiv1VFi13Klimt9nYz2UUvG4U/nkR7GQTu73GwHiQY8ta/EWoKvBwVht9+y18W2sV/lta0UG6aVToAl1vhw9vw3D8lQ5IrmjckoHf43jW16XNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481803; c=relaxed/simple;
	bh=6xUgLOFdCuxBZJL1hn9eXwjjUUhUqAR1+BQPgXPLP+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG1kzRN8vtMyyaf8u5K0/VouB85WsjD78pUWXZcOXXKWlQEVpFDQTnkW5hv6+1VbVwhmrbAx8+gga4rAQHPgjqmSZa36jdBrRoTCH1nIWoaniWAYxFMhvpf2ubg4tz90x4EV7oyDyz7Q9msGCfYfXsLCHpSX5B+GS09/flsSA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NT2Oe+sA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NT2Oe+sA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714481800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/gvLa7sIDHO8kY1gdoDajG1u00oK5nehvTUav+G6vTU=;
	b=NT2Oe+sAssldol8HAiPuUzLc/1ThrD0qqmbDJLTxN1zZYJpfRQbsnY1D5/ekDgE2FgoWeH
	dyWfKOBXjLoD2GJzlifV2qI3lO6WKtshghby20fddCeTtHHVuKm5xXPNlk44x6SozcM6Bh
	i/gDLYF0rsHl6rzF4HMQJ5VAKfFsEzc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-rydUZIUdMCO0RRe5jDuOEg-1; Tue, 30 Apr 2024 08:56:37 -0400
X-MC-Unique: rydUZIUdMCO0RRe5jDuOEg-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36c5ed3322aso2103205ab.1
        for <fstests@vger.kernel.org>; Tue, 30 Apr 2024 05:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714481796; x=1715086596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gvLa7sIDHO8kY1gdoDajG1u00oK5nehvTUav+G6vTU=;
        b=q5vcVlUa6ypw04Ls3AG7Cyof/6F3R3ZKBNhSt08r3q8hSUQ9ZmxMNKZQMvUUZk5Ved
         t33vl0h9zrMXVzEICR62VTmH2qbSg/FYBMsr848XmbptQBpa7ybPHdSNIjiwZaH126yt
         pIF5y7XKseds3cLNsvPtUVbIpm1zEkMfGsG1vL4doA0r9k5ksxneByrQDD0O8HVuJmBz
         WJc4mQuFFV/FFNmYDsGjMgRVn93oR5TRJPK3P9V4Pn0F9YZydbUNTzaYt/lqjQu5vJe3
         YAb9PCegKiRD7WS5Jray7R5Ze0KfTNwUk40mryF1aigm3BjJB7ZaN/q5Ojzqk89OGLJg
         jnTA==
X-Forwarded-Encrypted: i=1; AJvYcCWyeL+txQsiz6II+kRRWb8fmpTuIE3zmIif4ywy0yC8267qb/yyx5F2r0B4ZamD1/4J7RD4mJ+6zo+4zHQvELsHZVz2gGQmYQ==
X-Gm-Message-State: AOJu0YwLPD4YEEvRNe3ZMm1jEGUiVyizifFQ5yJsqJ7dSRtK6uFMlXkb
	vZs2v1xNqlYqPPZM+iqJElA6EY2XTgp/ADckrl+0vZLld2HuhBnn+IBcULjTXUwW+lPiqNNiaUm
	ZDF0EaXUM2xJV443jng5oSZJKPpptguJKt8+Z+wPM6L1fY/pLvwCmsg==
X-Received: by 2002:a05:6e02:1987:b0:36b:837:db0e with SMTP id g7-20020a056e02198700b0036b0837db0emr18708042ilf.1.1714481796425;
        Tue, 30 Apr 2024 05:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAF1DkWU7ljBktLEfu0Y8dV1p17PuOLL/W4Kwzja5W5B2CaMpV5ljAlwN7cy3HrodfzDUArw==
X-Received: by 2002:a05:6e02:1987:b0:36b:837:db0e with SMTP id g7-20020a056e02198700b0036b0837db0emr18708010ilf.1.1714481795897;
        Tue, 30 Apr 2024 05:56:35 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i1-20020a056e0212c100b0036c4d41e1ebsm1014741ilm.26.2024.04.30.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:56:35 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:56:32 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, ebiggers@kernel.org, fsverity@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, guan@eryu.me, linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 5/6] xfs: test disabling fsverity
Message-ID: <7v6qwlhjqrgz5vznrwkfucx2tz2uc4qbo4h7hivausf7fzf5wa@ecq64sxnj5t3>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <171444688055.962488.12884471948592949028.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171444688055.962488.12884471948592949028.stgit@frogsfrogsfrogs>

On 2024-04-29 20:42:05, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a test to make sure that we can disable fsverity on a file that
> doesn't pass fsverity validation on its contents anymore.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/1881     |  111 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1881.out |   28 +++++++++++++
>  2 files changed, 139 insertions(+)
>  create mode 100755 tests/xfs/1881
>  create mode 100644 tests/xfs/1881.out
> 
> 
> diff --git a/tests/xfs/1881 b/tests/xfs/1881
> new file mode 100755
> index 0000000000..411802d7c7
> --- /dev/null
> +++ b/tests/xfs/1881
> @@ -0,0 +1,111 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1881
> +#
> +# Corrupt fsverity descriptor, merkle tree blocks, and file contents.  Ensure
> +# that we can still disable fsverity, at least for the latter cases.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick verity
> +
> +_cleanup()
> +{
> +	cd /
> +	_restore_fsverity_signatures
> +	rm -f $tmp.*
> +}
> +
> +. ./common/verity
> +. ./common/filter
> +. ./common/fuzzy
> +
> +_supported_fs xfs
> +_require_scratch_verity
> +_disable_fsverity_signatures
> +_require_fsverity_corruption
> +_require_xfs_io_command noverity
> +_require_scratch_nocheck	# corruption test
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +_require_xfs_has_feature "$SCRATCH_MNT" verity
> +VICTIM_FILE="$SCRATCH_MNT/a"
> +_fsv_can_enable "$VICTIM_FILE" || _notrun "cannot enable fsverity"

also here, if not needed in 1880

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

