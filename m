Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B49C0015E
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 15:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjGMPJA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jul 2023 11:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjGMPI7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jul 2023 11:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E76B4
        for <fstests@vger.kernel.org>; Thu, 13 Jul 2023 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689260892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LKEgiO5m9UEOA1ymFrtn1vlOMXeKdTXdSXIjQGYSTHc=;
        b=SaI6XRox8gyOi7ZDx3o4dSQBX61YlWAFeQDyQbiKnekHwAGE1fbayMo6t6KDIGxbpx4wEH
        zN5XCVutzP5Y98Hk9jLIhVE3bKzz5KHC1jIDQcoTyWYhWWmy3xMavjFSe4tN8ay45EdvsJ
        A7x3vNqKK4q2ovf75Nxtt65DrCtzLZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-t1jOtid_O6WebTU-8fTGAA-1; Thu, 13 Jul 2023 11:08:06 -0400
X-MC-Unique: t1jOtid_O6WebTU-8fTGAA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 919BE8870EE;
        Thu, 13 Jul 2023 15:08:00 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C052492B01;
        Thu, 13 Jul 2023 15:08:00 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 7633A3096A42; Thu, 13 Jul 2023 15:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 710C93F7CF;
        Thu, 13 Jul 2023 17:08:00 +0200 (CEST)
Date:   Thu, 13 Jul 2023 17:08:00 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
In-Reply-To: <20230713014837.GG11442@frogsfrogsfrogs>
Message-ID: <bec4a75-3e5a-b688-6a29-3639d293b1a@redhat.com>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com> <20230713014837.GG11442@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On Wed, 12 Jul 2023, Darrick J. Wong wrote:

> Mikulas, does this solve the forkbomb problem?
> 
> --D

Yes, this patch works.

Tested-by: Mikulas Patocka <mpatocka@redhat.com>

Mikulas


> diff --git a/tests/generic/558 b/tests/generic/558
> index 4e22ce656b..de5c28d00d 100755
> --- a/tests/generic/558
> +++ b/tests/generic/558
> @@ -39,15 +39,21 @@ _scratch_mkfs_sized $((1024 * 1024 * 1024)) >>$seqres.full 2>&1
>  _scratch_mount
>  
>  i=0
> -free_inode=`_get_free_inode $SCRATCH_MNT`
> -file_per_dir=1000
> -loop=$((free_inode / file_per_dir + 1))
> +free_inodes=$(_get_free_inode $SCRATCH_MNT)
> +nr_cpus=$(( $($here/src/feature -o) * 4 * LOAD_FACTOR ))
> +echo "free inodes: $free_inodes nr_cpus: $nr_cpus" >> $seqres.full
> +
> +if ((free_inodes <= nr_cpus)); then
> +	nr_cpus=1
> +	files_per_dir=$free_inodes
> +else
> +	files_per_dir=$(( (free_inodes + nr_cpus - 1) / nr_cpus ))
> +fi
>  mkdir -p $SCRATCH_MNT/testdir
>  
>  echo "Create $((loop * file_per_dir)) files in $SCRATCH_MNT/testdir" >>$seqres.full
> -while [ $i -lt $loop ]; do
> -	create_file $SCRATCH_MNT/testdir $file_per_dir $i >>$seqres.full 2>&1 &
> -	let i=$i+1
> +for ((i = 0; i < nr_cpus; i++)); do
> +	create_file $SCRATCH_MNT/testdir $files_per_dir $i >>$seqres.full 2>&1 &
>  done
>  wait
>  
> 

