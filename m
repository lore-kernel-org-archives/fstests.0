Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBigEAGM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A753F1A5
	for <fstests@vger.kernel.org>; Wed,  6 Dec 2023 06:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701873748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2oJud2TeKpzJEG8s4IS0glsFy7yE2HV9z+mk6AEAqk=;
	b=WBigEAGMXz0/JmYzdgr2Y5lNog+Fr4tXsUC/3KbmdAKvnuH06+7b3v1fB2IdbvO+VApFb0
	nxfZMFTlNa8ZZFUTimVll8Vw517T9qJOAluJ5sprHKb0rNUvS33oZl9s6r1KNSuO95mygM
	GhIeLpWMxLhYcx0/07BXdtN+2qGbClw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-AngYVB7OMPmkd9XOPzM96A-1; Wed, 06 Dec 2023 09:42:26 -0500
X-MC-Unique: AngYVB7OMPmkd9XOPzM96A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 770B88AADC0;
	Wed,  6 Dec 2023 14:42:26 +0000 (UTC)
Received: from redhat.com (unknown [10.22.18.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BDA73C2E;
	Wed,  6 Dec 2023 14:42:26 +0000 (UTC)
Date: Wed, 6 Dec 2023 08:42:24 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Pavel Reichl <preichl@redhat.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH] xfs/598: Add missing "fixed_by" hints
Message-ID: <ZXCIUBykatrP7KKx@redhat.com>
References: <20231206071525.168036-1-preichl@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206071525.168036-1-preichl@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Wed, Dec 06, 2023 at 08:15:25AM +0100, Pavel Reichl wrote:
> Kernel patches, the very same as for xfs/597, are necessary for scrub
> to function as expected.
> 
> _check_xfs_filesystem: filesystem on /dev/sda3 failed scrub
> 
> xfs_scrub -v -d -n output ***
> EXPERIMENTAL xfs_scrub program in use! Use at your own risk!
> Phase 1: Find filesystem geometry.
> /mnt/scratch: using 2 threads to scrub.
> Phase 2: Check internal metadata.
> Info: AG 1 superblock: Optimization is possible. (scrub.c line 212)
> Info: AG 2 superblock: Optimization is possible. (scrub.c line 212)
> Info: AG 3 superblock: Optimization is possible. (scrub.c line 212)
> Phase 3: Scan all inodes.
> Corruption: inode 131 (0/131) directory entries: Repairs are required. (scrub.c line 196)
> Phase 5: Check directory tree.
> Info: /mnt/scratch: Filesystem has errors, skipping connectivity checks. (phase5.c line 392)
> Phase 7: Check summary counters.
> 203.0MiB data used;  5 inodes used.
> 64.2MiB data found; 5 inodes found.
> 5 inodes counted; 5 inodes checked.
> /mnt/scratch: corruptions found: 1
> /mnt/scratch: Re-run xfs_scrub without -n.
> end xfs_scrub output
> mount output ***
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
>  tests/xfs/598 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/xfs/598 b/tests/xfs/598
> index 449bd711..760cd861 100755
> --- a/tests/xfs/598
> +++ b/tests/xfs/598
> @@ -19,6 +19,11 @@ _cleanup()
>  _fixed_by_git_commit xfsprogs 10a01bcd \
>  	"xfs_db: fix metadump name obfuscation for ascii-ci filesystems"
>  
> +_fixed_by_kernel_commit a9248538facc \
> +        "xfs: stabilize the dirent name transformation function used for ascii-ci dir hash computation"
> +_fixed_by_kernel_commit 9dceccc5822f \
> +        "xfs: use the directory name hash function for dir scrubbing"
> +
>  _supported_fs xfs
>  _require_test
>  _require_scratch
> -- 
> 2.43.0
> 
> 

