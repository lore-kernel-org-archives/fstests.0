Return-Path: <SRS0=6hky=CY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4E9C43461
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 12:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06E420936
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 12:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXpHlQmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgIOMoi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 08:44:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54277 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbgIOMmT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 08:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600173725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DN0wQ83G5SHcHvpmUPEVwBGRG/lzoxVY4Z8D4ZCRuv4=;
        b=FXpHlQmqQkEt3XsZHIgY/ZbtQc5R/euDeUkq6Rz3lDkN1jE+/ui9OzJrv8YTOzYcImN51x
        6BWuSyU+hApyOWP+4w/xF4SXwoixuH0xNtWguUL53T5Cfg0yYGPDcUBxhvqAptckhMc6yQ
        1KcuLyEDbXtO4bGRpiBukvxwX5iN0hQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-fXxQdlb_O5GvlBvFic8XGQ-1; Tue, 15 Sep 2020 08:42:03 -0400
X-MC-Unique: fXxQdlb_O5GvlBvFic8XGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74DA2100A954
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 12:42:02 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A85915FC1B
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 12:42:01 +0000 (UTC)
Date:   Tue, 15 Sep 2020 20:55:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 02/24] generic/60[01]: fix test failure when setting new
 grace limit
Message-ID: <20200915125558.GS2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests@vger.kernel.org
References: <160013417420.2923511.6825722200699287884.stgit@magnolia>
 <160013418837.2923511.12713913160160876814.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160013418837.2923511.12713913160160876814.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 14, 2020 at 06:43:08PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> The setquota command can extend a quota grace period by a certain number
> of seconds.  The extension is provided as a number of seconds relative
> to right now.  However, if the system clock increments the seconds count
> after this test assigns $now but before setquota gets called, the test
> will fail because $get and $set will be off by that 1 second.  Allow for
> that.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/600 |    4 +++-
>  tests/generic/601 |    4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/tests/generic/600 b/tests/generic/600
> index 7ea0d6c2..42e4ee55 100755
> --- a/tests/generic/600
> +++ b/tests/generic/600
> @@ -60,7 +60,9 @@ let set=now+100
>  setquota -T -u $qa_user 0 100 $SCRATCH_MNT 2>&1 | grep -v "^setquota"
>  get=`repquota -up $SCRATCH_MNT | grep  "^$qa_user" | awk '{print $NF}'`
>  
> -if [ "$get" != "$set" ]; then
> +# Either the new expiry must match; or be one second after the set time, to
> +# deal with the seconds counter incrementing.
> +if [ "$get" != "$set" ] && [ "$get" -ne "$((set + 1))" ]; then
>  	echo "set grace to $set but got grace $get"
>  fi
>  
> diff --git a/tests/generic/601 b/tests/generic/601
> index 1baa6a90..b412ee8a 100755
> --- a/tests/generic/601
> +++ b/tests/generic/601
> @@ -71,7 +71,9 @@ $XFS_QUOTA_PROG -x -c "timer -u -i 100 $qa_user" $SCRATCH_MNT
>  # raw ("since epoch") grace expiry
>  get=`repquota -up $SCRATCH_MNT | grep  "^$qa_user" | awk '{print $NF}'`
>  
> -if [ "$get" != "$set" ]; then
> +# Either the new expiry must match; or be one second after the set time, to
> +# deal with the seconds counter incrementing.
> +if [ "$get" != "$set" ] && [ "$get" -ne "$((set + 1))" ]; then
>  	echo "set grace to $set but got grace $get"
>  fi
>  
> 

