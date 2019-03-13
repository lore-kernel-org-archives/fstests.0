Received: from mx1.redhat.com ([209.132.183.28]:51446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfCMMaG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 13 Mar 2019 08:30:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 162EDC08E2B9
        for <fstests@vger.kernel.org>; Wed, 13 Mar 2019 12:30:06 +0000 (UTC)
Date: Wed, 13 Mar 2019 20:33:59 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH] generic: unaligned direct AIO write test
Message-ID: <20190313123359.GH7200@dhcp-12-102.nay.redhat.com>
References: <20190312091944.2044-1-zlang@redhat.com>
 <20190313085238.pzfxvcdnm7sikas5@work>
 <20190313100341.GG7200@dhcp-12-102.nay.redhat.com>
 <20190313102610.istwizqfk4drvn2z@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313102610.istwizqfk4drvn2z@work>
Sender: fstests-owner@vger.kernel.org
To: Lukas Czerner <lczerner@redhat.com>
Cc: fstests@vger.kernel.org, fsorenso@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 13, 2019 at 11:26:10AM +0100, Lukas Czerner wrote:
> On Wed, Mar 13, 2019 at 06:03:42PM +0800, Zorro Lang wrote:
> > > > +		io_prep_pwrite(&iocb1, fd, buf, buf_size/2, \
> > > > +		               startoff + bytes + 0*buf_size/2);
> > > > +		io_prep_pwrite(&iocb2, fd, buf, buf_size/2, \
> > > > +		               startoff + bytes + 1*buf_size/2);
> > > 
> > > This is just a little bit confusing. I'd expect the write size to be a
> > > buffer size, not buffer size/2. Is there a reason you wanted to do it
> > > this way ?
> > 
> > The buf is used for below pread() too. We write twice separately at here,
> > so write buf/2 each time. Then read whole buf size once.
> 
> Sure, but from the persective of someone using this thing I'd expect the
> buf_size to be the size of the write. I do not think it matters too much
> as long as you can explain it in the description of the program.

OK, I'll change that.

> 
> > 
> > > 
> > > Also, do we need the size_KB ? I'd expect it would just do two writes.
> > > One starting in one block before i_size and ending before i_size but in
> > > the same block as i_size and the second starting beyond i_size but still
> > > in the same block as i_size.
> > > 
> > > I guess it does not hurt to be able to specify size_KB, but I wonder
> > > what was your reason to include it ?
> > > 
> > > Moreover I think it would be interesting to also allow the second write
> > > not to be aligned with i_size but still be in the same block. Something
> > > like:
> > > 
> > > 	io_prep_pwrite(&iocb1, fd, buf, buf_size, startoff);
> > > 	io_prep_pwrite(&iocb2, fd, buf, buf_size, startoff + buf_size + shift);
> > > 
> > > where "shift" (or whatever you want to call it) can be user specified.
> > 
> > Hmmm, I think I can do that in below generic/999, by provide different arguments
> > to $AIO_TEST.
> 
> Looking at the code I do not think you can, but maybe I am wrong.

Oh, you mean the 2nd io_prep_pwrite not start from i_size. OK, I'll add another
offset argument to affect the 2nd io_prep_pwrite.

> 
> > > > +localfile=$TEST_DIR/tst-aio-dio-testfile
> > > > +diosize=`_min_dio_alignment $TEST_DEV`
> > > > +pagesize=`src/feature -s`
> > > > +bufsize=$((pagesize * 2))
> > > > +filesize=$((bufsize * 3 / 1024))
> > > > +
> > > > +# Need smaller logical block size to do non-page-aligned test
> > > > +if [ $diosize -ge $pagesize ];then
> > > > +	_notrun "Need device logical block size($diosize) < page size($pagesize)"
> > > > +fi
> > > > +
> > > > +rm -rf $localfile 2>/dev/null
> > > > +# page-aligned aiodio write verification at first
> > > > +$AIO_TEST -s $((bufsize * 10)) -b $bufsize $localfile
> > > > +
> > > > +# non-page-aligned aiodio write verification
> > > > +i=0
> > > > +while [ $((diosize * i)) -lt $bufsize ];do
> > > > +	truncsize=$((diosize * i++))
> > > > +	# non-page-aligned AIO write on different i_size file
> > > > +	$AIO_TEST -s $filesize -b $bufsize -o $diosize -t $truncsize $localfile
> > > 
> > > Why are we starting the write at diosize when truncsize is getting
> > > bigger and bigger and filesize remains the same. . Is filesize
> > > necessary ?
> > 
> > The filesize is just used to decide how many times $AIO_TEST will write, then exit. It's
> > not related with this bug, just a limit condition.
> > 
> > That .c program is not only to reproduce that ext4 bug. It can be used to do direct AIO
> > write and verify. Then the generic/999 is used to cover that ext4 bug, and maybe cover
> > more operations.
> 
> Fair enough, just please decribe what the program is good for and what
> it can do. Currently it's not entirely clear.

Sure, Thanks for your review. I'll send a V2 patch later.

Thanks,
Zorro

> 
> Thanks!
> -Lukas
> 
> > 
> > Thanks,
> > Zorro
