Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A1FC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 17 Apr 2022 16:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiDQQm2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 Apr 2022 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbiDQQm1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Apr 2022 12:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 646F7BFB
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650213589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXFuVGrx+rL9QRAWxNQqLS632uUFF41hQXIR2/QjV4Y=;
        b=H36aSyJup7lyM2CVCf6VR+2u+U/Xs/9K3panN9oE1RjgUN/7WLS+HgN7VeLkib5i1ublze
        ZzdXTFRiLIbzyOk6yXa8z/pDwpr3Jwh8cNI0XkiQNk+4HljvarH8PGWAeDlYsT5kzsq5FH
        3Idu0S4meKBA0rD4hVr1GFkmWXBZ2bk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-2yZcawlsOGW_d0C6qJ4iNw-1; Sun, 17 Apr 2022 12:39:47 -0400
X-MC-Unique: 2yZcawlsOGW_d0C6qJ4iNw-1
Received: by mail-qk1-f198.google.com with SMTP id u6-20020a05620a430600b0069c0f5ad4e2so8885228qko.2
        for <fstests@vger.kernel.org>; Sun, 17 Apr 2022 09:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=DXFuVGrx+rL9QRAWxNQqLS632uUFF41hQXIR2/QjV4Y=;
        b=5XiyQJ4m3hUpHlX1P+7qixsAXScIHMCRuvuQpZK3Vtq82GXkCzPI9wD9Po2IxTaUed
         9Os3UEJF+i6y7GbUjoIscrEmzfRs5cmRPjbD/b/6G7TzhqmnHsCUyOVh96edQvF9gOeQ
         0z6/rxdNXx0kVQYlC3b+yx08hvn+HI/hpabAXDTbJfWjCXzKhUB9btZm2zzSap4K+zPV
         pen/3s1iuRZHyqqJH3LXfhG5Cf5Sg1j4922BuaAg9yXd2aS+TWldEwojeYjePqUNGj1W
         Ef93ZpQEqsgeTV8kZF2J595q9aikIk1cbxMp3KAVxHF8R7NO7iNSkzSXXjKylZU67jHY
         CeHA==
X-Gm-Message-State: AOAM532l16rbhqN+4aJFN1uz0eClXTT+Gpx2Bzp4Lqkkl3t07EhwL1bd
        Ua04ilwNLBy4PN/8rynSOXl/QHpjHRBoNQBHhtfYlZLPAA37BN0EMO2iTg9DwbjKdyIbx9i8fIU
        mGztaK1HWn1qeAvla3g==
X-Received: by 2002:a05:6214:f6f:b0:441:3a32:d6dd with SMTP id iy15-20020a0562140f6f00b004413a32d6ddmr5859460qvb.106.1650213587205;
        Sun, 17 Apr 2022 09:39:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaMnBsjbqN6hfeUu7GB34e13EgBJb+3SFHoIooSuECCax+3EdE4gbdqVeiEZKsW1VTgUJ3dg==
X-Received: by 2002:a05:6214:f6f:b0:441:3a32:d6dd with SMTP id iy15-20020a0562140f6f00b004413a32d6ddmr5859442qvb.106.1650213586898;
        Sun, 17 Apr 2022 09:39:46 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002f1fc230725sm988330qta.31.2022.04.17.09.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 09:39:46 -0700 (PDT)
Date:   Mon, 18 Apr 2022 00:39:40 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v1.1 3/3] xfs/216: handle larger log sizes
Message-ID: <20220417163940.rzjnwdpftntjuotg@zlang-mailbox>
Mail-Followup-To: Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <164971769710.170109.8985299417765876269.stgit@magnolia>
 <164971771391.170109.16368399851366024102.stgit@magnolia>
 <20220415150458.GB17025@magnolia>
 <20220416133518.sxow73joph3f7h7v@zlang-mailbox>
 <YlwnR1SvEiNussG3@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlwnR1SvEiNussG3@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 17, 2022 at 10:42:15PM +0800, Eryu Guan wrote:
> On Sat, Apr 16, 2022 at 09:35:18PM +0800, Zorro Lang wrote:
> > On Fri, Apr 15, 2022 at 08:04:58AM -0700, Darrick J. Wong wrote:
> > > mkfs will soon refuse to format a log smaller than 64MB, so update this
> > > test to reflect the new log sizing calculations.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  tests/xfs/216             |   19 +++++++++++++++++++
> > >  tests/xfs/216.out.64mblog |   10 ++++++++++
> > >  tests/xfs/216.out.classic |    0 
> > >  3 files changed, 29 insertions(+)
> > >  create mode 100644 tests/xfs/216.out.64mblog
> > >  rename tests/xfs/{216.out => 216.out.classic} (100%)
> > > 
> > > diff --git a/tests/xfs/216 b/tests/xfs/216
> > > index c3697db7..ebae8979 100755
> > > --- a/tests/xfs/216
> > > +++ b/tests/xfs/216
> > > @@ -29,6 +29,23 @@ $MKFS_XFS_PROG 2>&1 | grep -q rmapbt && \
> > >  $MKFS_XFS_PROG 2>&1 | grep -q reflink && \
> > >  	loop_mkfs_opts="$loop_mkfs_opts -m reflink=0"
> > >  
> > > +# Decide which golden output file we're using.  Starting with mkfs.xfs 5.15,
> > > +# the default minimum log size was raised to 64MB for all cases, so we detect
> > > +# that by test-formatting with a 512M filesystem.  This is a little handwavy,
> > > +# but it's the best we can do.
> > > +choose_golden_output() {
> > > +	local seqfull=$1
> > > +	local file=$2
> > > +
> > > +	if $MKFS_XFS_PROG -f -b size=4096 -l version=2 \
> > > +			-d name=$file,size=512m $loop_mkfs_opts | \
> > > +			grep -q 'log.*blocks=16384'; then
> > > +		ln -f -s $seqfull.out.64mblog $seqfull.out
> > > +	else
> > > +		ln -f -s $seqfull.out.classic $seqfull.out
> > > +	fi
> > 
> > Actually there's a old common function in common/rc named _link_out_file(),
> > xfstests generally use it to deal with multiple .out files. It would be
> > better to keep in step with common helpers, but your "ln" command
> > isn't wrong :)
> 
> I added tests/xfs/216.cfg file and updated test to use
> _link_out_file_named().

Thanks! Sorry have to trouble you, my request to kernel.org is still blocking.

`_link_out_file_named $seqfull.out 64mblog` is equal to
`_link_out_file 64mblog`

So the later one might be enough. Anyway, both are good to me!

Thanks,
Zorro

> 
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Thanks!
> Eryu
> 
> > 
> > > +}
> > > +
> > >  _do_mkfs()
> > >  {
> > >  	for i in $*; do
> > > @@ -43,6 +60,8 @@ _do_mkfs()
> > >  # make large holey file
> > >  $XFS_IO_PROG -f -c "truncate 256g" $LOOP_DEV
> > >  
> > > +choose_golden_output $0 $LOOP_DEV
> > > +
> > >  #make loopback mount dir
> > >  mkdir $LOOP_MNT
> > >  
> > > diff --git a/tests/xfs/216.out.64mblog b/tests/xfs/216.out.64mblog
> > > new file mode 100644
> > > index 00000000..3c12085f
> > > --- /dev/null
> > > +++ b/tests/xfs/216.out.64mblog
> > > @@ -0,0 +1,10 @@
> > > +QA output created by 216
> > > +fssize=1g log      =internal log           bsize=4096   blocks=16384, version=2
> > > +fssize=2g log      =internal log           bsize=4096   blocks=16384, version=2
> > > +fssize=4g log      =internal log           bsize=4096   blocks=16384, version=2
> > > +fssize=8g log      =internal log           bsize=4096   blocks=16384, version=2
> > > +fssize=16g log      =internal log           bsize=4096   blocks=16384, version=2
> > > +fssize=32g log      =internal log           bsize=4096   blocks=16384, version=2
> > > +fssize=64g log      =internal log           bsize=4096   blocks=16384, version=2
> > > +fssize=128g log      =internal log           bsize=4096   blocks=16384, version=2
> > > +fssize=256g log      =internal log           bsize=4096   blocks=32768, version=2
> > > diff --git a/tests/xfs/216.out b/tests/xfs/216.out.classic
> > > similarity index 100%
> > > rename from tests/xfs/216.out
> > > rename to tests/xfs/216.out.classic
> > > 
> 

