Return-Path: <SRS0=0vMW=YG=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8DBC4CECE
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Oct 2019 16:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E7C20659
	for <linux-fstests@archiver.kernel.org>; Sun, 13 Oct 2019 16:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cuFrfqAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfJMQYJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 13 Oct 2019 12:24:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfJMQYJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 13 Oct 2019 12:24:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9DGIdYX026861;
        Sun, 13 Oct 2019 16:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=kg6UKe/dgX+UkTWqUGk3ZAYM4FldfZJuou3+vcFVd74=;
 b=cuFrfqASJsOLYeBtjhnUwtTDRNXfWgidB4U1ePpdlwLfdF8Tto2GdW91zAT6Y62DD+Du
 OX55oK2bT5NCGc8jIl1nmlmvlTiQhNApfDtExEfo6DWsu16Dm7Bb+WKgsjbt9MGsi8Xy
 zegu7vf0Q4qa7I7dH8tUmUxfmpRhNr1cb6t/EtbODr07PphA9bcrPPIqWaCNCN1fHHsB
 Ifevr6p+u4jQ/vmOvPQmuCY0VjqbxeDsr/u83XkorXvWgwgYFIGvjKigqoRPBMHlNj1S
 C8gim/e/9aCZN9lrdPxukgIEznjAELu/f+DPDG0I8zBZo7oyuWGVjba0NWNbIxJjlpwU NA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vk7fqv9wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 16:23:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9DGNSfR068866;
        Sun, 13 Oct 2019 16:23:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vkry45pvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Oct 2019 16:23:54 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9DGNkr5002446;
        Sun, 13 Oct 2019 16:23:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 13 Oct 2019 09:23:46 -0700
Date:   Sun, 13 Oct 2019 09:23:45 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH v2] generic: check reflink multiple mmap write
Message-ID: <20191013162345.GJ13097@magnolia>
References: <20191010041440.GH13097@magnolia>
 <20191011214120.GI13097@magnolia>
 <20191013121134.GG2622@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013121134.GG2622@desktop>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910130164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910130163
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Oct 13, 2019 at 08:11:37PM +0800, Eryu Guan wrote:
> On Fri, Oct 11, 2019 at 02:41:20PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> > 
> > Add a test to make sure that we can handle multiple memory mappings to a
> > physical storage extent shared by multiple files, and that we can handle
> > the copy on write operation without error.  Make sure we can also handle
> > mappings at different offsets in the page cache.
> > 
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> > v2: test at different offsets
> > ---
> >  src/Makefile                |    2 -
> >  src/mmap-write-concurrent.c |  155 +++++++++++++++++++++++++++++++++++++++++++
> 
> I added an entry in .gitignore file.

Thanks!

<snip>
> > +
> > +# real QA test starts here
> > +_supported_os Linux
> > +_supported_fs generic
> > +_require_command "$FILEFRAG_PROG" filefrag
> 
> Also added
> 
> _require_test_program "mmap-write-concurrent"
> 

> > +echo "mwrite all copies" | tee -a $seqres.full
> > +off=$(( (filesz / 2) - 168 ))
> > +len=337
> > +./src/mmap-write-concurrent $len \
> 
> And used "$here/src/mmap-write-concurrent .." here.

Old habits die hard, I guess. :(  Thanks for fixing those up on
commit...

--D

> Thanks,
> Eryu
> 
> > +		$off $testdir/file1 \
> > +		$off $testdir/file2 \
> > +		$off $testdir/file3 \
> > +		$off $testdir/file4 \
> > +		$((off + blksz)) $testdir/file5 \
> > +		$((off + (blksz * 2))) $testdir/file6 \
> > +		$((off + (blksz * 3))) $testdir/file7 \
> > +		$((off + (blksz * 4))) $testdir/file8 \
> > +		168 $testdir/file1 \
> > +		$((blksz - 168)) $testdir/file2 \
> > +		$((filesz - 777)) $testdir/file3 \
> > +		$(((blksz * 3) - 168)) $testdir/file4 \
> > +
> > +
> > +echo "Compare files before remount" | tee -a $seqres.full
> > +compare
> > +_test_cycle_mount
> > +
> > +echo "Compare files after remount" | tee -a $seqres.full
> > +compare
> > +
> > +echo "Check for non-shared extents" | tee -a $seqres.full
> > +$FILEFRAG_PROG -v $testdir/file1 $testdir/file2 $testdir/file3 $testdir/file4 \
> > +		  $testdir/file5 $testdir/file6 $testdir/file7 $testdir/file8 \
> > +		  | grep '^[[:space:]]*[0-9]*:' > $testdir/fiemap
> > +cat $testdir/fiemap >> $seqres.full
> > +grep -q 'shared' $testdir/fiemap || \
> > +		echo "Expected to find shared extents"
> > +
> > +grep -q -v 'shared' $testdir/fiemap || \
> > +		echo "Expected to find non-shared extents"
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/945.out b/tests/generic/945.out
> > new file mode 100644
> > index 00000000..ad1e21ff
> > --- /dev/null
> > +++ b/tests/generic/945.out
> > @@ -0,0 +1,31 @@
> > +QA output created by 945
> > +Create the original files
> > +Compare files before cow
> > +c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file1
> > +c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file2
> > +c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file3
> > +c946b71bb69c07daf25470742c967e7c  TEST_DIR/test-945/file4
> > +74e6b9b1a03fdf09293c089b002800f8  TEST_DIR/test-945/file5
> > +c14f20b97155e3fc11a17532d02ad9df  TEST_DIR/test-945/file6
> > +22eb46e0f4a3742c8d86346845b7bc80  TEST_DIR/test-945/file7
> > +4d292f06cec9d3f1bece4822cd5ef532  TEST_DIR/test-945/file8
> > +mwrite all copies
> > +Compare files before remount
> > +c1b46135a2620ae6da21bbfd4cbb3cba  TEST_DIR/test-945/file1
> > +16f0bc0f97c42d2ad903c519095b8126  TEST_DIR/test-945/file2
> > +eb71e3135ca2abf33bb9081e2b49a876  TEST_DIR/test-945/file3
> > +2678dfcb77bed4dc29e19836bef82e5b  TEST_DIR/test-945/file4
> > +2802d75dbee4f29d62124aa7b473edca  TEST_DIR/test-945/file5
> > +acd58cf3d33ef905e26800a0e049223c  TEST_DIR/test-945/file6
> > +1b68d203e5a1c1b45a9510bedcd1e126  TEST_DIR/test-945/file7
> > +9479709b697ced2e3a57c17bc1b97373  TEST_DIR/test-945/file8
> > +Compare files after remount
> > +c1b46135a2620ae6da21bbfd4cbb3cba  TEST_DIR/test-945/file1
> > +16f0bc0f97c42d2ad903c519095b8126  TEST_DIR/test-945/file2
> > +eb71e3135ca2abf33bb9081e2b49a876  TEST_DIR/test-945/file3
> > +2678dfcb77bed4dc29e19836bef82e5b  TEST_DIR/test-945/file4
> > +2802d75dbee4f29d62124aa7b473edca  TEST_DIR/test-945/file5
> > +acd58cf3d33ef905e26800a0e049223c  TEST_DIR/test-945/file6
> > +1b68d203e5a1c1b45a9510bedcd1e126  TEST_DIR/test-945/file7
> > +9479709b697ced2e3a57c17bc1b97373  TEST_DIR/test-945/file8
> > +Check for non-shared extents
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 4584667f..f77c5b21 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -576,3 +576,4 @@
> >  715 dangerous_norepair
> >  716 dangerous_norepair
> >  720 dangerous_norepair
> > +945 auto quick rw clone
