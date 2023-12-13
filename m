Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP+KgG2F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D53210F
	for <fstests@vger.kernel.org>; Wed, 13 Dec 2023 07:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PGqY0zpAwgtTtqJaGj+enSH2iEuKiSr77nLL5Ee7Nko=;
	b=IP+KgG2F82z38xUwFkcT0AP5lhqrjD71lOI7/gEQvYnsgD4L/AP0qNYDDCDRH4TKS38Y+e
	Z2WJCiek0BThrulN2cY79iu8gAPiPIhkfNlXPO3SVOUZhRPe6QV0NToZb2iMd3ckc0mhaA
	2BjkAig/TDIeQvY6a+cXFB/826NtbOI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-hNisMHDXOwimiJs1EPVeRA-1; Wed, 13 Dec 2023 10:34:37 -0500
X-MC-Unique: hNisMHDXOwimiJs1EPVeRA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28ade5535d4so1164846a91.0
        for <fstests@vger.kernel.org>; Wed, 13 Dec 2023 07:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702481676; x=1703086476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGqY0zpAwgtTtqJaGj+enSH2iEuKiSr77nLL5Ee7Nko=;
        b=Bg/tyYotV2NtwDrwiPCri1eAMJO1YQpMtvFXyXByllAguDlPzarl5r2Y7Nm5N+iqc4
         RuD0YQPsKwi23ANOD2yQGpF86iSW3yilfKU8pAZTleHpeWgvrtx5Ivn97O2I57mtFR71
         pP15hX+DHE4HuLYxbkPNQcATlb5WOiIaEELqZX28ZgowvLzoTKRw7OOHGp6ub1y9N03M
         t0FCkDLIxcMDNoGKpLa/qVxlAJaCX7Ntw065HJuAuMzbINXob66yt+vDpsjqNWDOx64y
         YAbXU/AO0wP0XxqSp8kuZSBGcvlGfwskxl90oFZGDaE/VQdoxpBYiT1T7qPfJMrx0fkr
         c+TQ==
X-Gm-Message-State: AOJu0Yx2akCB92b0SgJXJOewT5tgE6wsqGJ5oc0aICuy+Ae186EqScZk
	KI6iu2nwf4SZDU/XXxyjiMM+AkYU4ILiRwwZ1MtVLBZTyu5oB0RmH/vcccCSUBIx6LfOZ9Ch/eO
	WCGJV09HUa31v9RaSSQ==
X-Received: by 2002:a17:90b:2e46:b0:28a:ea3c:4b19 with SMTP id sm6-20020a17090b2e4600b0028aea3c4b19mr540632pjb.95.1702481676088;
        Wed, 13 Dec 2023 07:34:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3WnKbhHIngnheK8CjltRNRy0p/KVZGc4KwiIEPxBZpyDoa+fCGF9CmB0zWODQfjgpojhZAQ==
X-Received: by 2002:a17:90b:2e46:b0:28a:ea3c:4b19 with SMTP id sm6-20020a17090b2e4600b0028aea3c4b19mr540625pjb.95.1702481675737;
        Wed, 13 Dec 2023 07:34:35 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c11-20020a17090a020b00b00286d75e10e4sm13744422pjc.37.2023.12.13.07.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:34:35 -0800 (PST)
Date: Wed, 13 Dec 2023 23:34:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/new: drop caches while freeze
Message-ID: <20231213153431.eu4ii7ljmssgynyl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231213092043.1621684-1-jencce.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213092043.1621684-1-jencce.kernel@gmail.com>

On Wed, Dec 13, 2023 at 05:20:43PM +0800, Murphy Zhou wrote:
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  tests/generic/734     | 34 ++++++++++++++++++++++++++++++++++

Hi Murphy,


Thanks for this new test. Sorry that g/734 has been taken last weekend,
please rebase to the latest for-next branch.

>  tests/generic/734.out |  2 ++
>  2 files changed, 36 insertions(+)
>  create mode 100755 tests/generic/734
>  create mode 100644 tests/generic/734.out
> 
> diff --git a/tests/generic/734 b/tests/generic/734
> new file mode 100755
> index 00000000..8ca91930
> --- /dev/null
> +++ b/tests/generic/734
> @@ -0,0 +1,34 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test 734
> +#
> +# Test possible deadlock of umount and reclaim memory
> +# when there are EOF blocks in files.

Is there a known bug fix for this case? If yes, please specify that by:
"_fixed_by_kernel_commit xxxxxxxxxx xxxxxxxxxxxxxxxx".

> +#
> +. ./common/preamble
> +_begin_fstest freeze auto quick
> +
> +_supported_fs generic
> +_require_scratch

This's a geneirc case, not all fs support fsfreeze, so ...
_require_freeze

And ...

_scratch_mkfs >> $seqres.full ??
_scratch_mount ??

> +
> +$XFS_IO_PROG -fc "pwrite 0 64k" $SCRATCH_MNT/testfile >> $seqres.full

Could you explain why there're two duplicated lines below? If it's intended,
better to have a comment to explain why do it twice (not once or more times).

> +cat $SCRATCH_MNT/testfile >> $SCRATCH_MNT/testfile1
> +cat $SCRATCH_MNT/testfile >> $SCRATCH_MNT/testfile1
> +
> +sync
> +
> +fsfreeze -f $SCRATCH_MNT

All cases in fstests do fs freeze by xfs_freeze. If there's not special
reason, better to keep consistency. Due to the _require_freeze checks
that too.

> +
> +# This will hang if bug reproduces
> +echo 3 > /proc/sys/vm/drop_caches &

I'm wondering, if the data in cache has been written back and been cleared
before fsfreeze or this step, what will happen? If the cache data is necessary,
should we load/read more data/files to provide that?

> +
> +# Manually unfreeze after a while
> +sleep 5
> +fsfreeze -u $SCRATCH_MNT
> +
> +wait

As there's a fs freeze in this case, so we'd better to do a "forced" unfreeze
in _cleanup, to make sure the fs will be unfreezed 100%, no matter what. So
you can move these two lines to _cleanup.

> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/734.out b/tests/generic/734.out
> new file mode 100644
> index 00000000..4299839b
> --- /dev/null
> +++ b/tests/generic/734.out
> @@ -0,0 +1,2 @@
> +QA output created by 734
> +Silence is golden
> -- 
> 2.31.1
> 
> 

