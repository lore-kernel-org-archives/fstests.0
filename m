Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB1DC43334
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 19:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiFBTNq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbiFBTNp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Jun 2022 15:13:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBE0715A16
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654197224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wcPIAoi9bFHYRxFYmf8Z6s4NSZgevOu2cZdxtUzPdWM=;
        b=ceLJjF1xcf45xGxT371c5TseVac7SCChdutyxux/i8l6AGEAiENld7ZPDTTYSCoe0m5cJU
        VsvE0W8Sy+dyhvS2dtJ4RFlZcvA6d1q81WeiHCV2lEBZJc3lxRMOnYXpq3A96iic6byzvn
        HNG9+eCTTLc0vRcrVUCB9Gfg/b2v5rY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-bmwQJotGM4CxUbLmr1xy-A-1; Thu, 02 Jun 2022 15:13:42 -0400
X-MC-Unique: bmwQJotGM4CxUbLmr1xy-A-1
Received: by mail-qv1-f69.google.com with SMTP id q11-20020a05621410eb00b0046261e8925bso3992215qvt.14
        for <fstests@vger.kernel.org>; Thu, 02 Jun 2022 12:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wcPIAoi9bFHYRxFYmf8Z6s4NSZgevOu2cZdxtUzPdWM=;
        b=yh88iUNciwTc8fGAc5FjFCTwaje27kn04x/IfZ+G3BmPuYOjHZwCHKeVFTmZ9Dx6qt
         lheCb508Mku67Z18rCUyFJ3Uv1RDpNhgH79wcxOmLlTDNoOmTgu0EQ2p4w6g4tKLXSPu
         beAmvAOfTSKmTybZIatrVk3/ISr7uaiAwX5PM3mZ6/saqPdTCeGa4g90mryeCq/2LyeM
         UNKTCbzUIxrFaO7cX4SI8iI6a28w5hCWjKjs5WRSDhOr/C9conJ4JXt+lkKzuiEbgZ9L
         uVaMYpdXbgf6801Qv94rSJPQO9xuhvXN7WP/CaH/LbfEgwiqqHuNvPAWchZFP0UlGrCg
         TwlQ==
X-Gm-Message-State: AOAM531dnvLw0dZY+tUahqHvFMjKSFaDHcZsIKDEZkaVw/2rVEVx0bTb
        zXlcuN4S1MyC9nC4UC0w/f35KWfH6/4rUU/2WRKDv/27BrePpeOJwP3vvjvW2ZsX7F/BdkHvpRV
        YImkjwbdWs5AJwF4bcA==
X-Received: by 2002:a05:622a:54f:b0:2f3:d566:e22c with SMTP id m15-20020a05622a054f00b002f3d566e22cmr4897344qtx.466.1654197222166;
        Thu, 02 Jun 2022 12:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKX+LEdeRReTH79Vjnbs/r9wSQ8TsAmQUG2gzCbek9f2mLuEp1yaa7q7XevXSEaMSotX2f8A==
X-Received: by 2002:a05:622a:54f:b0:2f3:d566:e22c with SMTP id m15-20020a05622a054f00b002f3d566e22cmr4897327qtx.466.1654197221844;
        Thu, 02 Jun 2022 12:13:41 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m3-20020a375803000000b006a3696c4739sm3783965qkb.19.2022.06.02.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 12:13:41 -0700 (PDT)
Date:   Fri, 3 Jun 2022 03:13:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/139: require 512 bytes to be the minimum dio
 size
Message-ID: <20220602191336.ay5jfz2hjna34ge4@zlang-mailbox>
References: <YpeixjeZ8kdVw/+7@magnolia>
 <20220602051716.2050004-1-zlang@kernel.org>
 <YpjoDZ9Gi1ouhcMe@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpjoDZ9Gi1ouhcMe@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 09:40:45AM -0700, Darrick J. Wong wrote:
> On Thu, Jun 02, 2022 at 01:17:16PM +0800, Zorro Lang wrote:
> > Due to generic/139 tests base on 512 bytes aligned, so skip this test
> > if the minimum dio write size >512. This patch also change the
> > common/rc::_require_dio helper, supports a minimum aligned size
> > argument.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > Thanks the review from Darrick on v2, this v3 remove some duplicate code
> > which I forgot.
> > 
> > Thanks,
> > Zorro
> > 
> >  common/rc         | 13 ++++++++++---
> >  tests/generic/139 |  2 +-
> >  2 files changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 2f31ca46..9823e3a1 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2721,9 +2721,12 @@ _require_xfs_io_command()
> >  	fi
> >  }
> >  
> > -# check that kernel and filesystem support direct I/O
> > +# check that kernel and filesystem support direct I/O, and check if "$1" size
> > +# aligned (optional) is supported
> >  _require_odirect()
> >  {
> > +	local alignment=${1:+"-b $1"}
> 
> This might be a nit, but you might want to do this instead:
> 
> 	local blocksize=$1
> 	local align_args=${1:+"-b $1"}
> 
> So that there's only one "$1" to change if the arguments ever get
> rearranged.  But that might never happen, and this feels nearly like
> pointless navelgazing.
> 
> If you're happy with things the way they are, the logic looks ok so:

OK, I respect the meticulous attitude, will do that when I merge it :)

> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > +
> >  	if [ $FSTYP = "ext4" ] || [ $FSTYP = "f2fs" ] ; then
> >  		if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"; then
> >  			_notrun "$FSTYP encryption doesn't support O_DIRECT"
> > @@ -2735,9 +2738,13 @@ _require_odirect()
> >  		fi
> >  	fi
> >  	local testfile=$TEST_DIR/$$.direct
> > -	$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
> > +	$XFS_IO_PROG -F -f -d -c "pwrite $alignment 0 20k" $testfile > /dev/null 2>&1
> >  	if [ $? -ne 0 ]; then
> > -		_notrun "O_DIRECT is not supported"
> > +		if [ -n "$alignment" ]; then
> > +			_notrun "O_DIRECT aligned to $1 bytes is not supported"
> > +		else
> > +			_notrun "O_DIRECT is not supported"
> > +		fi
> >  	fi
> >  	rm -f $testfile 2>&1 > /dev/null
> >  }
> > diff --git a/tests/generic/139 b/tests/generic/139
> > index 0bbc222c..3eb1519d 100755
> > --- a/tests/generic/139
> > +++ b/tests/generic/139
> > @@ -26,7 +26,7 @@ _cleanup()
> >  # real QA test starts here
> >  _require_test_reflink
> >  _require_cp_reflink
> > -_require_odirect
> > +_require_odirect 512
> >  
> >  testdir=$TEST_DIR/test-$seq
> >  rm -rf $testdir
> > -- 
> > 2.31.1
> > 
> 

