Return-Path: <SRS0=lZLm=5T=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C1C43331
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Apr 2020 03:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACEB20675
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Apr 2020 03:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGl9jUwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbgDCDhj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Apr 2020 23:37:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57076 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388951AbgDCDhj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Apr 2020 23:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585885057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCejLyVBPwcpCYScqinbv/4HqQRQqSFdIyz/w0hh6IU=;
        b=WGl9jUwgOFoEaa6uMWtmxMOg6tAAzkMgT8Rfu3bZHz3t8K3M+cqCujvR2sW6p3zGgbs8E4
        xI0v2xxNfm4zyA2NkSjk37VToiYYTRgw+WROd80YdpFok7DpZZcE3BHRJxEvZxUSeirOPp
        CJZbfqBihOZz2jGwqOPdLuW8toMxCt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-PIqmuyNJNrGZwwC1RmZU5A-1; Thu, 02 Apr 2020 23:37:34 -0400
X-MC-Unique: PIqmuyNJNrGZwwC1RmZU5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0D8818AB2C2;
        Fri,  3 Apr 2020 03:37:33 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14C611001DD8;
        Fri,  3 Apr 2020 03:37:32 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:49:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yongcheng Yang <yongcheng.yang@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/565: change to use filter
 _filter_testdir_and_scratch
Message-ID: <20200403034924.GV14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Yongcheng Yang <yongcheng.yang@gmail.com>,
        fstests@vger.kernel.org
References: <20200403003231.25098-1-yongcheng.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403003231.25098-1-yongcheng.yang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 03, 2020 at 08:32:31AM +0800, Yongcheng Yang wrote:
> If $TEST_DIR is a substring of $SCRATCH_MNT (like /mnt and /mnt2),
> this test always fail. Change to use _filter_testdir_and_scratch
> which will filter the longer string first if the other string is a
> substring of the longer one.
> 
> Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
> ---
> 
> Previously it failed with 565.out.bad:
> ~~~
> QA output created by 565
> md5sums after xdev copy:
> 81615449a98aaaad8dc179b3bec87f38  TEST_DIR/test-565/file
> 81615449a98aaaad8dc179b3bec87f38  TEST_DIR2/copy
> ~~~
> 
> It can pass with this patch:
> ~~~
> [09:18:16 root@ /var/lib/xfstests]# DIFF_LENGTH=-0 ./check -nfs generic/565
> FSTYP         -- nfs
> PLATFORM      -- Linux/x86_64 kvm-guest 4.18.0-193.el8.x86_64 #1 SMP Fri Mar 27 14:35:58 UTC 2020
> MKFS_OPTIONS  -- test-machine.com:/export-xfstests/dir2
> MOUNT_OPTIONS -- -overs=4 -o context=system_u:object_r:root_t:s0 test-machine.com:/export-xfstests/dir2 /mnt/nfsmp2
> 
> generic/565	 10s
> Ran: generic/565
> Passed all 1 tests
> ~~~
> 
> Thanks,
> Yongcheng
> 
>  tests/generic/565 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/565 b/tests/generic/565
> index 39eb20c8..41d85b91 100755
> --- a/tests/generic/565
> +++ b/tests/generic/565
> @@ -57,7 +57,7 @@ echo $testio | grep -q "cross-device" && \
>  echo -n $testio
>  cmp $testdir/file $SCRATCH_MNT/copy
>  echo "md5sums after xdev copy:"
> -md5sum $testdir/file $SCRATCH_MNT/copy | _filter_test_dir | _filter_scratch
> +md5sum $testdir/file $SCRATCH_MNT/copy | _filter_testdir_and_scratch

Looks good to me.

If a case need to filter scratch and test together, it really need to use
_filter_testdir_and_scratch. I've check all xfstests cases:

  $ grep -rsn _filter_scratch tests/|grep _filter_test
  tests/generic/565:60:md5sum $testdir/file $SCRATCH_MNT/copy | _filter_test_dir | _filter_scratch

Good news is only g/565 use _filter_test_dir and _filter_scratch together now.
So we don't need to change other cases likes this patch.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  
>  # success, all done
>  status=0
> -- 
> 2.20.1
> 

