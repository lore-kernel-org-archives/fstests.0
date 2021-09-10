Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E1C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Sep 2021 06:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A768D611AF
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Sep 2021 06:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhIJGfV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Sep 2021 02:35:21 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:63839 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhIJGfU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Sep 2021 02:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631255650; x=1662791650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fmzKMVFoE4jLm4sE7uFRDVXB0rRDqo6/IgB3XyNk5IU=;
  b=ITO/kvIpyRInoJBY9iLoDFPDKX74lkJApPjZDclw1MR444ZwE7HPyj9W
   YbIvirfDbSgmvqBNzjgPA0Udzbd3+GUvI88qfg6qPESL7U7B2V1S/hkQ+
   AvBFPmzLuF8BLbAX230inI2hoOo54fd5ELeTpNmt5BMJt1WMbjULPSZ4K
   CWz+cX7jB1pOmCLV4gbPZvA4bnpfT2Cvl/JjbwvN74zgzKNVrHq+mPkl+
   8y50f/kfs1mxkYu1Ww0UDL4UYe8IVx984YT2hma/1Z0m56vrI/Mm98uJk
   YQjJm5zubLXuahMQdJ4FpicLhR4WW2dUoPrLKJPQVqID3PtI4jjDrabJ9
   g==;
X-IronPort-AV: E=Sophos;i="5.85,282,1624291200"; 
   d="scan'208";a="180189296"
Received: from mail-dm3nam07lp2048.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.48])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2021 14:34:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0+vOnzKaBoV15TkBnq9ta8NRUshOGKCxlBAGo2c9MokfhtN0WTn7pXltjrvcQHUqwta6MZJZ/uBoFTQ4rlBkpfTN8caQsLNx72O4ssDq0SksiYKk8iCVtzWqznNMGovsadEsheuuH/wsomF1dvXnvIH8GNy3hZMn3DffnFWSgks0yg9sHxZK56Xz4t40XofwvY2AJ7wGRL8prtd9cx43m2Gu80BrfZE8imaySbefqgGdCMvLp1AgPS29rtlfPewXHg1ccBxjIaeoJNzVKXw+6G5xN3+2juR/wTF7Y6SeeYN7hCEu7MWCSf67SpnL1WYzxDBW3Zth5mXPkPOabggQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=PVNeCsAVsnVz/Tu5oTcWO5mg3zBSEB8HAhMzmJegG8I=;
 b=XOYH083Mx69rMZFLCvsQPlCofDGF03N/7Ec4+JxmXtOciVGqTove20JveteQng+cEyed0v8r5yGCNZx+P0usZ6qee/+6O1TMlgZOtSsjeyCa1DDzIHo1BPztMZWzfEqRWSSMqsmk4dV5UG9FKiZCG5pQ+QgSrZq2mxHFexAiKjbX9W6zC6TTzGVDnqFFCZA3NIR3Jkxfuk6Fc9aPaM/3RmvQ1RIuhJ1U9LeVgeg6RJrKx3YoPSOCXfAeyQSqPAxYMOoWg2XwFjF3tt/y9WareHVcjPwl/y0a/wrnW3YvbFkpFK+31b9AKkGb7Nv1GV+snAqRUmFSnspDFCR76lmK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVNeCsAVsnVz/Tu5oTcWO5mg3zBSEB8HAhMzmJegG8I=;
 b=rNvE52z20nebxbjqoP4lv8Zz9T8IDnEnS4JRMYMotbAY1/YEVXWvQQVBb4O5vz4cB7CKeZCp9s6N4eq0kbg6lSmkGjgWRz1mF4XPdR8XRNFUJlrg24cgRZyOnGPUjdh4oDTEutS2P7lM+j/bO0gR2gO62YbVw51YEaMH6OiwX3E=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB4567.namprd04.prod.outlook.com (2603:10b6:a03:56::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 06:34:06 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79%5]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 06:34:05 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 3/3] common/rc: Check call order of _require_dm_target
 and _require_scratch*
Thread-Topic: [PATCH v2 3/3] common/rc: Check call order of _require_dm_target
 and _require_scratch*
Thread-Index: AQHXpIzA8lUQHZVkikKQjd9zp8guFaucciyAgABgboA=
Date:   Fri, 10 Sep 2021 06:34:05 +0000
Message-ID: <20210910063405.j36w2oec2sqi6lob@shindev>
References: <20210908083715.1831067-1-shinichiro.kawasaki@wdc.com>
 <20210908083715.1831067-4-shinichiro.kawasaki@wdc.com>
 <20210910004857.GI1756565@dread.disaster.area>
In-Reply-To: <20210910004857.GI1756565@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fromorbit.com; dkim=none (message not signed)
 header.d=none;fromorbit.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 742c53a8-f0e6-45d2-5338-08d97424fcdc
x-ms-traffictypediagnostic: BYAPR04MB4567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4567CED0E73EB4A6A13E3350EDD69@BYAPR04MB4567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jSNX13yF/wAQ4CZWSKhCW4ecLUpiIIio7ZM5Z9rdN918HWuz6stX4OP9aRJKuuRTMyRGkBlPvPJ/zNVXsofw8b+Y+w1sXf8i+2yk3mUdUmbYS/KfBHy7DI/vE6l8AA4T/Zpnlu1mwvphlQLvbNlRlDXxeH2VBU2lyJeSowRcsBj+3/6zkCfA4XcAL+y7V8IzZNmKWj/BPDC0gHe0CLigOhHTRml18S7wK58Gtc5XuuBD6GS+4wwQZN510AomYrA6MJPVF0ub/mNtNtXSb8QRFGmd/EygK5YyjXW0T03tJ4p06gb0jprxUnt1kNYMYb0T2v9DQQR8e3Tx54Qd3F4QlR4J49+uZIFQT+ksNe1HHuFy6pelB68IaPBJtYCeMDqLNMrIUj07+32qj8WS9x4sksP4ednOkOk+kGD68gvUXlbLL8ualU4HxT3itNlKWADo5rPEHEAaGWNZy/LsoLi1K/WeGGxH43+biarJDKG8rp+pcLuaF8RCGI3H0+UMNTpDCcTnvbVHdOLA4jGj/XdQ30fLRKMcCE+I9rRk6raoxkotc32DmAa82OfCFPs4KU+UONOpY++KGSoHTyIQP7Kz4o894ov8qQy+kIFb5Xd2cUI9qyaFoVVBW5sT1DuZ+kLOX/GAcwVMgb1ahe1ubRG/MKsZugac1RbBpwW63aY55ez3PiALWkwtChOVjyFUd+uzw1zyhfDxOle/bjTwPrZLiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(38100700002)(6506007)(478600001)(38070700005)(9686003)(76116006)(86362001)(71200400001)(2906002)(6486002)(5660300002)(122000001)(91956017)(1076003)(6512007)(33716001)(66476007)(44832011)(8936002)(8676002)(186003)(83380400001)(4326008)(54906003)(6916009)(26005)(66946007)(64756008)(316002)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CXO5/BsMRA/w/9Xwlzfsh43fZ7dPeDA2F9irHD1nLLJvS8PShrSC58GyBkpT?=
 =?us-ascii?Q?8OsUzBe4WV7TReUZutjXAUYDS41TJHq7wNXPIwsCV+y3AupfW1uVYVBLZ2BD?=
 =?us-ascii?Q?yanqNFc0Wvzs02Bqxjfoc4DAVku7tiToYWvnvDxYsjCVgEVRvVY5843TcaYZ?=
 =?us-ascii?Q?KeQorbksvrehDI+Q7R77Fm9PuZ+WN4i+h337K0AikTEDfBo5JaeI70NsOLxk?=
 =?us-ascii?Q?XSipx+S2rJOiOV4xBIFPMZ0IcfqtP6/FWoyP9WGHzgkR/lN81EG1mMNkCATY?=
 =?us-ascii?Q?+gbm3CNX8uy9OX5+rRB2oIFhnxDKYvpS/0fsJL+tk+n09R+QG3HY4E4hOF4u?=
 =?us-ascii?Q?RgLp73KuDAg87mCCF4pNMflfV+ALLzTRptp3aMyReG+amLOKY/gpdLRedLiQ?=
 =?us-ascii?Q?ETr4Eu1tPWTwdvqh4edNbMEjWZyqZ8T7mItR5xOfMSWQNOTYvvXLQ7mu5GqJ?=
 =?us-ascii?Q?u1+RTiwuT3I9Yg1wB9VWzaguU2iY61Y+NJjSxXvHwRqbu8L7HtNzkn4VGc4R?=
 =?us-ascii?Q?hrf+MJZVUcsIz6L9XGOD6dgWzrVnt0W8jG1a16z6eFQp9Hxv9w+vuv4HokTP?=
 =?us-ascii?Q?arhmYf32fxx8IJWvLPNz4KpPp8jD5USR1ik2YR+AIhmSRuOIHz8Lrj5wy1i3?=
 =?us-ascii?Q?F0d9x6GYFDJ5Dg4kajwdIwi3b0VIqOY6KlPckwZVYCTeoM7E+rL9WqC2k6M7?=
 =?us-ascii?Q?sC4Amw7JwCxS3U6GvL1lmbBBiS7zBEt3cv6zQcjeHm1vtzpfny4BGNQjD46W?=
 =?us-ascii?Q?FpXdq0NzfUpvk6YsftaR83g86PQO8bxXYG1gP6WbHxLSQTkZrSKS3nqYP0C9?=
 =?us-ascii?Q?7EwUXk53psOz/fBwKky4FK50yt/n+lkQO3Brtbj7Blv6lw5e1Sz7uCj7QKap?=
 =?us-ascii?Q?K8eSiN+8GThfyy/cv3UqzFLPswVV1bXGtYA9gFxsfCw7HpNw69hBhfm+c7Hh?=
 =?us-ascii?Q?fv6kgPheOvRCbc3kn1ta0SxUUQGWNRwemESNCRw0wvH2G4G1dXswrQp8ppc6?=
 =?us-ascii?Q?W1p4DEtXBo6LAGSvfApj+e/4BskGxWSuqsLmAtC/Lo0Lh3AnJJA92Ipa9pO7?=
 =?us-ascii?Q?fyJPj1MD+/gP5eoeceY/tgl31btlP/m+zoOyi/ulLZz0zWAcI+FlzOGiG42H?=
 =?us-ascii?Q?ziErayILS8qYEeHXm1HnBEoi4kg06+EhY6I39syEFe1MDH56N6r6wnYpQovd?=
 =?us-ascii?Q?F9lg7+IPO3P2E25jYvodpD/5mrsNkqOZU5ecSKj3lgGiV6Mp0wOTz0vzYjRv?=
 =?us-ascii?Q?vsvT/hAjmEATi6nK++qcOfuFUjADH3c3qPRuU3Gk/1ng7JjzqskopBBxFz3Y?=
 =?us-ascii?Q?zgK8yU+bAOVtMUwRACg4Yup0M6WmghHyflvrMO+HzBpu0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD307B0282520243A5603EBE802E82C7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742c53a8-f0e6-45d2-5338-08d97424fcdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 06:34:05.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9JBf0Dp48ffZuPS/vtawY0SDupo08HvIa/VHGuZAE/TsTpKliIp1iQ9WtZEYcLHiahzEirg2m1nBfOz4Ku3Coo9gW1RM0CMpkE8D3SLdEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4567
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sep 10, 2021 / 10:48, Dave Chinner wrote:
> On Wed, Sep 08, 2021 at 05:37:15PM +0900, Shin'ichiro Kawasaki wrote:
> > When SCRATCH_DEV is not set and the test case does not call
> > _require_scratch* before _require_dm_target, _require_block_device
> > called from _require_dm_target fails to evaluate SCRATCH_DEV and
> > results in the test case failure. This failure reason is not described
> > in the error message and it takes some time to catch.
>=20
> You should quote the actual failure message here so we have some
> idea of whether the message that was emitted was appropriate or not
> without having to go know how the test failed...

Sorry about the lack of the infomration. As you found below, the meesage wa=
s
"Usage: _require_block_device <dev>".

>=20
> > To catch the failure reason easier, check SCRATCH_DEV in
> > _require_dm_target. If SCRATCH_DEV is not set, fail the test case
> > and print message which requests to fix call order of _require_scratch*
> > and _require_dm_target. This improvement follows what _scratch_shutdown
> > does for _require_scratch_shutdown.
>=20
> Also, you don't need to describe the change in the commit message -
> the patch does that. The first paragraph is all that is needed here
> as it describes why you want to make the change.

I see. I will write "why" in the commit message, not "what". (In the past, =
I
was advised to write "what" the patch does, but I think this guide is valid
only when the change is complicated).

>=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  common/rc | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/common/rc b/common/rc
> > index dda5da06..cbec8aaa 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1971,6 +1971,9 @@ _require_dm_target()
> > =20
> >  	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
> >  	# behaviour
> > +	if [ -z "$SCRATCH_DEV" ]; then
> > +		_fail "_require_dm_target: call _require_scratch* first in test"
> > +	fi
> >  	_require_block_device $SCRATCH_DEV
> >  	_require_sane_bdev_flush $SCRATCH_DEV
> >  	_require_command "$DMSETUP_PROG" dmsetup
>=20
> That's a notrun case, not a fail.
>=20
> Also, we report the error that has occurred, not how to resolve the
> problem. That's because we might change behaviour in future and now
> the error message tells people to do something that is
> wrong/non-existent. As such, I think the premise this change is based
> on is not really valid - people running fstests are assumed to have
> a level of knowledge sufficient to trace a failing test and
> determine what went wrong from the error reported. i.e. the error
> message should state what the problem was, not describe a potential
> solution.

Thank you for the comment. These are the points I missed. At least I was
able to catch the cause, so the improvement I suggested is not a big
improvement.

>=20
> Also, this is not the place to check if SCRATCH_DEV is set. The
> check for a NULL device should be in _require_block_device(). Oh,
> wait, it already is:
>=20
> _require_block_device()
> {
> 	if [ -z "$1" ]; then
> 		echo "Usage: _require_block_device <dev>" 1>&2
> 		exit 1
> 	fi
> ....
> }
>=20
> And that's the error message the test emitted that you didn't
> understand, right?

Right :)

>=20
> If so, the change here should really be to _require_block_device().
> i.e.
>=20
> 	if [ -z "$1" ]; then
> 		_notrun "test requires a block device to be specified"
> 	fi
>=20
> A quick scan shows a bunch of similar _requires checks that do
> similar things with poor error messages and 'exit 1' (e.g.
> _require_local_device()). _requires rules should call _notrun if the
> test should not run because of incorrect setup, not 'exit 1'.

Thank you for your thoughts. I walked through _require_* bash functions in
common/, and listed 20 functions below, which call 'exit 1', _fail, or
'return 1' for its argument check failure:

--- list start ---

common/rc

  _require_scratch_size
  _require_scratch_size_nocheck
  _require_command *
  _require_block_device *
  _require_local_device *
  _require_zoned_device *
  _require_non_zoned_device *
  _require_scratch_ext4_feature
  _require_xfs_io_command
  _require_fio
  _require_batched_discard *
  _require_chattr
  _require_fs_sysfs
  _require_scratch_feature

common/btrfs

  _require_btrfs_mkfs_feature
  _require_btrfs_fs_feature

common/xfs

  _require_xfs_db_command
  _require_xfs_spaceman_command

common/encrypt

  _require_encryption_policy_support (checks arguments passed from _require=
_scratch_encryption)

common/rnameat2

  _require_renameat2

--- list end ---

Many of the functions above check arguments not for incorrect setup, but fo=
r
call in test cases with invalid arguments. 6 functions of them with * in th=
e
list check arguments for the incorrect setups, such as DEBUGFS_PROG,
SCRATCH_DEV or SCRATCH_MNT. So I suggest to modify these functions to impro=
ve
error messages and call "_notrun". What do you think about this?

--=20
Best Regards,
Shin'ichiro Kawasaki=
